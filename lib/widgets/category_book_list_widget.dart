// ignore_for_file: use_super_parameters

import 'package:books_app/model/book.dart';
import 'package:flutter/material.dart';

class BookListWidget extends StatelessWidget {
  final List<Book> books;
  final String categoryName;

  const BookListWidget({Key? key, required this.books, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            leading: book.thumbnail != null
                ? Image.network(book.thumbnail!)
                : null,
            title: Text(book.title),
            subtitle: Text(book.subtitle ?? ''),
          );
        },
      ),
    );
  }
}
