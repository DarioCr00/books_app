// ignore_for_file: use_super_parameters

import 'package:books_app/widgets/floating_navbar_widget.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FloatingBottomNavBar(),
    );
  }
}