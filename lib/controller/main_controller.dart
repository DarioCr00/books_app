// ignore_for_file: avoid_print

import 'package:books_app/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:books_app/model/book.dart';

class MainController {
  Future<List<Book>> fetchBooks(String query) async {
    final url = googleBooksApiUrl(query);
    print('Fetching books from: $url');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response data: $data');
      if (data['items'] != null) {
        final books = (data['items'] as List).map((item) {
          final book = Book.fromJson(item['volumeInfo']);
          print('Book: ${book.title}, Thumbnail: ${book.thumbnail}');
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
}