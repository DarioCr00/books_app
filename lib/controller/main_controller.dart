// ignore_for_file: avoid_print

import 'dart:isolate';

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
    final url = googleBooksApiUrl(query);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
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
    final books = await fetchBooksInBackground("Il Signore degli Anelli Tolkien");
    if (books.isNotEmpty) {
      return books.first;
    } else {
      throw Exception('No book found for the recommended one');
    }
  }

  Future<List<Book>> fetchPopularBooks() async {
    return await fetchBooksInBackground("Lo Hobbit");
  }

  Future<List<Book>> searchBooksByCategory(String category) async {
    return await fetchBooksInBackground("subject:$category");
  }

  Future<List<Book>> getFavouriteBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favouriteBooks = prefs.getStringList('favouriteBooks') ?? [];
    return favouriteBooks.map((bookJson) => Book.fromJson(json.decode(bookJson))).toList();
  }

  Future<List<Book>> fetchBooksInBackground(String query) async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_fetchBooksIsolate, receivePort.sendPort);
    SendPort sendPort = await receivePort.first;
    return await _sendReceive(sendPort, query);
  }

  static void _fetchBooksIsolate(SendPort sendPort) async {
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
    ReceivePort receivePort = ReceivePort();
    sendPort.send([query, receivePort.sendPort]);
    return receivePort.first;
  }


  void checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void updateTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = isDarkMode;
    await prefs.setBool('isDarkMode', isDarkMode);
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
