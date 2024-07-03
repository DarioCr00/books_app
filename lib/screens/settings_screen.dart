// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final ScrollController scrollController;

  const SettingsScreen({Key ? key, required this.scrollController}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: const Text('To be Implemented...')
    );
  }
}