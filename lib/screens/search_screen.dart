// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:books_app/widgets/categories_widget.dart';
import 'package:flutter/material.dart';
import 'package:books_app/controller/main_controller.dart';
import 'package:books_app/widgets/search_books_widget.dart';

//Screen used to search books by title or by category
class SearchScreen extends StatefulWidget {

  const SearchScreen({Key ? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final MainController _mainController = MainController();
  bool _isSearchActive = false;

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
    });
  }
  
  //Depending on the mode selected the screen will feature the category icons/category results or a search bar/search results
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Visibility(
            visible: !_isSearchActive,
            child: CategoriesWidget(mainController: _mainController),
          ),
          Visibility(
            visible: _isSearchActive,
            child: GestureDetector(
              onTap: _toggleSearch,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: SearchBooksWidget(
                    mainController: _mainController,
                    onSearchResults: (results) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleSearch,
        child: Icon(_isSearchActive ? Icons.close : Icons.search),
      ),
    );
  }
}