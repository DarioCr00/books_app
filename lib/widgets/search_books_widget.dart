// ignore_for_file: library_private_types_in_public_api, use_super_parameters, avoid_print

import 'package:books_app/pages/book_page.dart';
import 'package:books_app/widgets/favourite_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:books_app/controller/main_controller.dart';
import 'package:books_app/model/book.dart';

class SearchBooksWidget extends StatefulWidget {
  final MainController mainController;
  final Function(List<Book>) onSearchResults;

  const SearchBooksWidget({
    Key? key,
    required this.mainController,
    required this.onSearchResults,
  }) : super(key: key);

  @override
  _SearchBooksWidgetState createState() => _SearchBooksWidgetState();
}

class _SearchBooksWidgetState extends State<SearchBooksWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _books = [];
  bool _isLoading = false;
  String _errorMessage = '';

  void _searchBooks() async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        final books = await widget.mainController.fetchBooksInBackground(query);
        setState(() {
          _books = books;
          _isLoading = false;
        });
        widget.onSearchResults(books);
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for books',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchBooks,
                ),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_isLoading)
            const CircularProgressIndicator()
          else if (_errorMessage.isNotEmpty)
            Text(_errorMessage, style: const TextStyle(color: Colors.red))
          else if (_books.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];
                  final thumbnailUrl = book.thumbnail;
                  return ListTile(
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
                    trailing: FavouriteButtonWidget(
                      book: book,
                      onFavouriteChanged: (isFavourite) {
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => BookPage(book: book),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
