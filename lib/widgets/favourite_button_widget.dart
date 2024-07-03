// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';

class FavouriteButtonWidget extends StatefulWidget {
  const FavouriteButtonWidget({Key ? key}) : super(key: key);

  @override
  _FavouriteButtonWidgetState createState() => _FavouriteButtonWidgetState();

}

class _FavouriteButtonWidgetState extends State<FavouriteButtonWidget> {
  bool _isFavourite = false;

  void _toggleFavourite() {
    setState(() {
      _isFavourite = !_isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleFavourite,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Add to Favourites'),
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