// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:books_app/model/book.dart';
import 'package:flutter/material.dart';

class FavouriteButtonWidget extends StatefulWidget {
  final Book book;

  const FavouriteButtonWidget({Key? key, required this.book}) : super(key: key);

  @override
  _FavouriteButtonWidgetState createState() => _FavouriteButtonWidgetState();
}

class _FavouriteButtonWidgetState extends State<FavouriteButtonWidget> {
  bool _isFavourite = false;

  void _toggleFavourite() {
    setState(() {
      _isFavourite = !_isFavourite;
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
    return ElevatedButton(
      onPressed: _toggleFavourite,
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