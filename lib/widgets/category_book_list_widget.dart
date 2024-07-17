// ignore_for_file: use_super_parameters, avoid_print

import 'package:books_app/controller/main_controller.dart';
import 'package:books_app/model/book.dart';
import 'package:books_app/pages/book_page.dart';
import 'package:books_app/widgets/favourite_button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookListWidget extends StatefulWidget {
  final String categoryName;

  final MainController mainController;

  const BookListWidget({
    Key? key,
    required this.categoryName,
    required this.mainController,
  }) : super(key: key);

  @override
  State<BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  late List<Book> _books;
  bool _isLoading = true;

  _getBooks() async {
    setState(() => _isLoading = true);
    _books =
        await widget.mainController.searchBooksByCategory(widget.categoryName);
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        centerTitle: true,
      ),
      //listview to display the list of books
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                final thumbnailUrl = book.thumbnail;
                return GestureDetector(
                  onTap: () async {
                    bool? updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookPage(book: book),
                      ),
                    );
                    if (updated == true) {
                      _getBooks();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 15,
                          child: thumbnailUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: thumbnailUrl,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) {
                                    print('Error loading image: $thumbnailUrl');
                                    return const Icon(Icons.error);
                                  },
                                )
                              : const Icon(Icons.book),
                        ),
                        Expanded(
                            flex: 45,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(book.title),
                            )),
                        Expanded(
                          flex: 15,
                          child: FavouriteButtonWidget(
                            book: book,
                            onFavouriteChanged: (isFavourite) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
