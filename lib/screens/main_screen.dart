// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:books_app/screens/favourite_books_screen.dart';
import 'package:books_app/screens/home_screen.dart';
import 'package:books_app/screens/search_screen.dart';
import 'package:books_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key ? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  final ScrollController _scrollController = ScrollController();

  @override 
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override 
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            HomeScreen(scrollController: _scrollController),
            SearchScreen(scrollController: _scrollController),
            FavouriteBooksScreen(scrollController: _scrollController),
            SettingsScreen(scrollController: _scrollController),
          ],
        ),
        bottomNavigationBar: Hidable(
          controller: _scrollController,
          enableOpacityAnimation: true,
          preferredWidgetSize: const Size.fromHeight(107),
          child: Container(  
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey[400],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _buildBottomNavBarItem(
                index: 0,
                icon: Icons.home,
                selectedColor: Colors.brown,
              ),
              _buildBottomNavBarItem(
                index: 1,
                icon: Icons.search,
                selectedColor: Colors.green,
              ),
              _buildBottomNavBarItem(
                index: 2,
                icon: Icons.star,
                selectedColor: Colors.yellow,
              ),
              _buildBottomNavBarItem(
                index: 3,
                icon: Icons.settings,
                selectedColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavBarItem({
    required int index,
    required IconData icon,
    required Color selectedColor,
  }) {
    bool isSelected = _currentIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.grey[200] : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isSelected ? selectedColor : Colors.grey[400],
        ),
      ),
      label: '',
    );
  }
}