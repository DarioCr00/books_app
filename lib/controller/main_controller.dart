// ignore_for_file: avoid_print

import 'dart:isolate';
import 'dart:math';

import 'package:books_app/utils/api_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:books_app/model/book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final RxBool _isDarkMode = false.obs;
  RxBool get isDarkMode => _isDarkMode;

  @override
  void onInit() {
    checkTheme();
    super.onInit();
  }

  Future<List<Book>> fetchBooks(String query, {String? category}) async {
    //function to obtain book info via API call

    final url = googleBooksApiUrl(query); //see utils/api_url.dart
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //we get data in json format and we save it in a Book object (model/book.dart)
      final data = json.decode(response.body);
      if (data['items'] != null) {
        final books = (data['items'] as List).map((item) {
          final book = Book.fromJson(item['volumeInfo']);
          return book;
        }).toList();
        return books;
      } else {
        print('No items found in the response');
      }
    } else {
      print('Failed to fetch books. Status code: ${response.statusCode}');
    }
    throw Exception('Failed to load books');
  }

  Future<Book> fetchBookRecommended() async {
    //for now just fecthes a predetermined book (future implementation)
    final books =
        await fetchBooksInBackground("Il Signore degli Anelli Tolkien");
    if (books.isNotEmpty) {
      return books.first; //Returns only the first one
    } else {
      throw Exception('No book found for the recommended one');
    }
  }

  Future<List<Book>> fetchPopularBooks() async {
    //for now just fecthes the results of a predetermined query (future implementation)
    List<Book> books = await fetchBooksInBackground("fantasy");

    //Selecting a random set of books
    books.shuffle(Random());

    //Returning the first 10 books or less
    return books.take(10).toList();
  }

  Future<List<Book>> searchBooksByCategory(String category) async {
    //calls fetchBooks using the parameter subject: to search for a category of books
    return await fetchBooksInBackground("subject:$category");
  }

  Future<List<Book>> getFavouriteBooks() async {
    //function to obtain books saved as favourite via SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favouriteBooks = prefs.getStringList('favouriteBooks') ?? [];
    return favouriteBooks
        .map((bookJson) => Book.fromJson(json.decode(bookJson)))
        .toList();
  }

  Future<List<Book>> fetchBooksInBackground(String query) async {
    //function that spawns an Isolate to fetch books using a different thread
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_fetchBooksIsolate, receivePort.sendPort);
    SendPort sendPort = await receivePort.first;
    return await _sendReceive(sendPort, query);
  }

  static void _fetchBooksIsolate(SendPort sendPort) async {
    //the previously mentioned Isolate spawned by fetchBooksInBackground
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    await for (var msg in receivePort) {
      String query = msg[0];
      SendPort replyTo = msg[1];
      try {
        List<Book> books = await MainController().fetchBooks(query);
        replyTo.send(books);
      } catch (e) {
        replyTo.send(e.toString());
      }
    }
  }

  Future _sendReceive(SendPort sendPort, String query) {
    //method used for Isolate communication
    ReceivePort receivePort = ReceivePort();
    sendPort.send([query, receivePort.sendPort]);
    return receivePort.first;
  }

  void checkTheme() async {
    //method used to get theme setting info saved with SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void updateTheme(bool isDarkMode) async {
    //method used to modify theme setting info and save it with SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = isDarkMode;
    await prefs.setBool('isDarkMode', isDarkMode);
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
