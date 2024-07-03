// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:books_app/controller/main_controller.dart';
import 'package:books_app/widgets/search_books_widget.dart';

class SearchScreen extends StatefulWidget {
  final ScrollController scrollController;

  const SearchScreen({Key ? key, required this.scrollController}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final MainController _mainController = MainController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
        centerTitle: true,
      ),
      body: SearchBooksWidget(
        mainController: _mainController,
        onSearchResults: (results) {
          setState(() {
          });
        },
      ),
    );
  }
}