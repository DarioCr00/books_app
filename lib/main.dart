// ignore_for_file: use_super_parameters, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:books_app/controller/main_controller.dart';
import 'package:books_app/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(44, 44, 44, 1),
          ),
        ),
        
        theme: ThemeData(
          brightness: Brightness.light,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
          ),
        ),
        
        home: const MainScreen(),
      );
    });
  }
}
