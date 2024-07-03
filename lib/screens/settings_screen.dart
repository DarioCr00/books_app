// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:books_app/controller/main_controller.dart';

class SettingsScreen extends StatefulWidget {
  final ScrollController scrollController;

  const SettingsScreen({Key? key, required this.scrollController}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      final ThemeData currentTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();

      return Scaffold(
        appBar: AppBar(
          title: Text('Preferences'),
          backgroundColor: currentTheme.appBarTheme.backgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView(
            children: [
              ListTile(
                title: Text('Set Dark Mode'),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    mainController.updateTheme(value);
                  },
                  activeColor: Colors.blueGrey,
                ),
              ),
              const Divider(indent: 16.0, endIndent: 16.0),
            ],
          ),
        ),
      );
    });
  }
}
