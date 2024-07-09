// ignore_for_file: avoid_print

import 'package:books_app/utils/api_url.dart';
import 'package:books_app/utils/work_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:books_app/model/book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

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
    final books = await fetchBooks("Il Signore degli Anelli Tolkien");
    if (books.isNotEmpty) {
      return books.first;
    } else {
      throw Exception('No book found for the recommended one');
    }
  }

  Future<List<Book>> fetchPopularBooks() async {
    return await fetchBooks("Lo Hobbit");
  }

  Future<List<Book>> searchBooksByCategory(String category) async {
    return await fetchBooks("subject:$category");
  }

  // Background tasks
  Future<void> fetchBooksInBackground(String query) async {
    await fetchBooks(query);
  }

  Future<void> fetchBookRecommendedInBackground() async {
    await fetchBookRecommended();
  }

  Future<void> fetchPopularBooksInBackground() async {
    await fetchPopularBooks();
  }

  void scheduleFetchBooks(String query) {
    Workmanager().registerOneOffTask(
      fetchBooksTask,
      fetchBooksTask,
      inputData: {'query': query},
    );
  }

  void scheduleFetchBookRecommended() {
    Workmanager().registerOneOffTask(
      fetchBookRecommendedTask,
      fetchBookRecommendedTask,
    );
  }

  void scheduleFetchPopularBooks() {
    Workmanager().registerOneOffTask(
      fetchPopularBooksTask,
      fetchPopularBooksTask,
    );
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
