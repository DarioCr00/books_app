// ignore_for_file: use_super_parameters, avoid_print

import 'package:books_app/model/book.dart';
import 'package:books_app/pages/book_page.dart';
import 'package:books_app/widgets/favourite_button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          final thumbnailUrl = book.thumbnail;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => BookPage(book: book),
                ),
              );
            },
            child: ListTile(
              leading: thumbnailUrl != null
                ? CachedNetworkImage(
                    imageUrl: thumbnailUrl,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) {
                      print('Error loading image: $thumbnailUrl');
                      return const Icon(Icons.error);
                    },
                  )
                : const Icon(Icons.book),
              title: Text(book.title),
              subtitle: Text(book.subtitle ?? ''),
              trailing: FavouriteButtonWidget(book: book),
            ),
          );
        },
      ),
    );
  }
}
