import 'package:prova/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
}

class Book {
  final String title;
  final String? subtitle;
  final String? thumbnail;

  Book({required this.title, this.subtitle, this.thumbnail});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      subtitle: json['subtitle'],
      thumbnail: json['imageLinks'] != null ? json['imageLinks']['thumbnail'] : null,
    );
  }
}