// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:books_app/controller/main_controller.dart';
import 'package:books_app/screens/main_screen.dart';

void main() {
  Get.put(MainController()); // Inizializzare il MainController
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'Books App',
        themeMode: mainController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        home: const MainScreen(),
      );
    });
  }
}
