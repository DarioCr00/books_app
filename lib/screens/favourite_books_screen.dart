// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

class FavouriteBooksScreen extends StatefulWidget {

  const FavouriteBooksScreen({Key ? key}) : super(key: key);

  @override
  _FavouriteBooksScreenState createState() => _FavouriteBooksScreenState();
}

class _FavouriteBooksScreenState extends State<FavouriteBooksScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Books'),
        centerTitle: true,
      ),
      body: const Text('To be Implemented...')
    );
  }
}