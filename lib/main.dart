// ignore_for_file: use_super_parameters

import 'package:books_app/widgets/floating_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:books_app/controller/main_controller.dart';

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
        home: const FloatingBottomNavBar(),
      );
    });
  }
}
