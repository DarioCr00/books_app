// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:books_app/controller/main_controller.dart';
import 'package:books_app/model/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteBooksScreen extends StatefulWidget {

  const FavouriteBooksScreen({Key ? key}) : super(key: key);

  @override
  _FavouriteBooksScreenState createState() => _FavouriteBooksScreenState();
}

class _FavouriteBooksScreenState extends State<FavouriteBooksScreen> {
  final MainController _mainController = Get.find<MainController>();
  late Future<List<Book>> _favouriteBooks;

  @override
  void initState() {
    super.initState();
    _favouriteBooks = _mainController.getFavouriteBooks();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Books'),
        centerTitle: true,
      ),
      body:  FutureBuilder<List<Book>>(
        future: _favouriteBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favourite books'));
          } else {
            final books = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          book.thumbnail ?? 'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(book.authors.join(', ')),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}