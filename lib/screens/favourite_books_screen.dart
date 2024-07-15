// ignore_for_file: use_super_parameters, library_private_types_in_public_api, avoid_print

import 'package:books_app/controller/main_controller.dart';
import 'package:books_app/model/book.dart';
import 'package:books_app/pages/book_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        future: _favouriteBooks, //the future to be resolved
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookPage(book: book),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: book.thumbnail ?? 'https://via.placeholder.com/150',
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              print('Error loading image:');
                              return const Icon(Icons.error);
                            },
                            fit: BoxFit.cover, //cover the available space with the image
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