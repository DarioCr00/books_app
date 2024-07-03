// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:books_app/widgets/book_recommended_widget.dart';
import 'package:books_app/widgets/popular_books_widget.dart';
import 'package:flutter/material.dart';
import 'package:books_app/controller/main_controller.dart';
import 'package:books_app/model/book.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;

  const HomeScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainController _mainController = Get.put(MainController());
  Book? _bookRecommended;
  List<Book> _popularBooks = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });
      final bookRecommended = await _mainController.fetchBookRecommended();
      final popularBooks = await _mainController.fetchPopularBooks();
      setState(() {
        _bookRecommended = bookRecommended;
        _popularBooks = popularBooks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
                  ? Center(child: Text(_errorMessage, style: const TextStyle(color: Colors.red)))
                  : SingleChildScrollView(
                      controller: widget.scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_bookRecommended != null)
                            BookRecommendedWidget(book: _bookRecommended!),
                          const SizedBox(height: 20),
                          const Text(
                            'Most popular',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          PopularBooksWidget(books: _popularBooks),
                        ],
                      ),
                    ),
        ),
        //backgroundColor: _mainController.isDarkMode.value ? Colors.black : Colors.white,
      );
  }
}
