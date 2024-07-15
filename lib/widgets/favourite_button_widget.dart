// ignore_for_file: library_private_types_in_public_api, use_super_parameters, avoid_print

import 'dart:convert';

import 'package:books_app/model/book.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteButtonWidget extends StatefulWidget {
  final Book book;
  final Function(bool) onFavouriteChanged;

  const FavouriteButtonWidget({Key? key, required this.book, required this.onFavouriteChanged}) : super(key: key);

  @override
  _FavouriteButtonWidgetState createState() => _FavouriteButtonWidgetState();
}

class _FavouriteButtonWidgetState extends State<FavouriteButtonWidget> {
  bool _isFavourite = false;
  bool _isLoading = true;

  @override 
  void initState() {
    super.initState();
    //load the initial favourite status from shared pref
    _loadFavouriteStatus();
  }

  void _loadFavouriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favouriteBooks = prefs.getStringList('favouriteBooks') ?? [];
    setState(() {
      _isFavourite = favouriteBooks.contains(json.encode(widget.book.toJson()));
      _isLoading = false;
    });
  }

  //toggle the favourite status and update shared pref
  void _toggleFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favouriteBooks = prefs.getStringList('favouriteBooks') ?? [];
    setState(() {
      if(_isFavourite) {
        favouriteBooks.remove(json.encode(widget.book.toJson()));
      } else {
        favouriteBooks.add(json.encode(widget.book.toJson()));
      }
      prefs.setStringList('favouriteBooks', favouriteBooks);
      _isFavourite = !_isFavourite;
      widget.onFavouriteChanged(_isFavourite);
    });
    // Stampa il titolo del libro
    if(_isFavourite) {
      print("Aggiunto ${widget.book.title} ai preferiti");
    } else {
      print("Rimosso ${widget.book.title} dai preferiti");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const Center(child: CircularProgressIndicator(),) : ElevatedButton(
      onPressed: _toggleFavourite, //when pressed updates the favourite status
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isFavourite ? 'Remove' : 'Add',
            style: TextStyle(
              color: _isFavourite ? const Color.fromARGB(255, 165, 123, 31): null,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            _isFavourite ? Icons.star : Icons.star_border,
            color: _isFavourite ? Colors.yellow : Colors.grey,
          ),
        ],
      ),
    );
  }
}