// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:books_app/controller/main_controller.dart';

class SettingsScreen extends StatefulWidget {
  

  const SettingsScreen({Key? key}) : super(key: key);

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
          title: const Text('Preferences'),
          centerTitle: true,
          backgroundColor: currentTheme.appBarTheme.backgroundColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'General',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.brightness_6, color: Colors.blue),
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        mainController.updateTheme(value);
                      },
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.blue.withOpacity(0.5),
                      inactiveTrackColor: Colors.white,
                    ),
                  ),
                  const Divider(indent: 16.0, endIndent: 16.0),
                  ListTile(
                    leading: const Icon(Icons.language, color: Colors.blue),
                    title: const Text('Language'),
                    trailing: const Text('English'),
                    onTap: () {
                      // Future Implementation
                    },
                  ),
                  const Divider(indent: 16.0, endIndent: 16.0),
                  ListTile(
                    leading: const Icon(Icons.notifications, color: Colors.blue),
                    title: const Text('Notifications'),
                    onTap: () {
                      // Future Implementation
                    },
                  ),
                  const Divider(indent: 16.0, endIndent: 16.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Account & Security',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.blue),
                    title: const Text('Account Information'),
                    onTap: () {
                      // Future Implementation
                    },
                  ),
                  const Divider(indent: 16.0, endIndent: 16.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Other',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip, color: Colors.blue),
                    title: const Text('Privacy Policy'),
                    onTap: () {
                      // Future Implementation
                    },
                  ),
                  const Divider(indent: 16.0, endIndent: 16.0),
                  ListTile(
                    leading: const Icon(Icons.description, color: Colors.blue),
                    title: const Text('Terms & Conditions'),
                    onTap: () {
                      // Future Implementation
                    },
                  ),
                  const Divider(indent: 16.0, endIndent: 16.0),
                  ListTile(
                    leading: const Icon(Icons.info, color: Colors.blue),
                    title: const Text('About Us'),
                    onTap: () {
                      // Add functionality to show about us information
                    },
                  ),
                  const Divider(indent: 16.0, endIndent: 16.0),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'App Version 1.0.0',
                      style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            )
          ],
        )  
        );
    });
  }
}

