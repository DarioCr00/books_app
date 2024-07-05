import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final int bookCount;

  Category({required this.name, required this.icon, required this.bookCount});
}

final List<Category> categories = [
  Category(name: 'Action & Adventure', icon: Icons.local_fire_department, bookCount: 155),
  Category(name: 'Art', icon: Icons.brush, bookCount: 60),
  Category(name: 'Biography & Autobiography', icon: Icons.person, bookCount: 70),
  Category(name: 'Business & Economics', icon: Icons.business, bookCount: 120),
  Category(name: 'Comics & Graphic Novels', icon: Icons.menu_book, bookCount: 100),
  Category(name: 'Computers', icon: Icons.computer, bookCount: 50),
  Category(name: 'Cooking', icon: Icons.kitchen, bookCount: 80),
  Category(name: 'Drama', icon: Icons.theater_comedy, bookCount: 150),
  Category(name: 'Family & Relationships', icon: Icons.family_restroom, bookCount: 90),
  Category(name: 'Fantasy', icon: Icons.auto_awesome, bookCount: 85),
  Category(name: 'Fiction', icon: Icons.book, bookCount: 200),
  Category(name: 'Health & Fitness', icon: Icons.fitness_center, bookCount: 65),
  Category(name: 'History', icon: Icons.history, bookCount: 70),
  Category(name: 'Horror', icon: Icons.person_4_sharp, bookCount: 50),
  Category(name: 'Humor', icon: Icons.emoji_emotions, bookCount: 100),
  Category(name: 'Mystery', icon: Icons.search, bookCount: 110),
  Category(name: 'Philosophy', icon: Icons.psychology, bookCount: 55),
  Category(name: 'Poetry', icon: Icons.edit, bookCount: 40),
  Category(name: 'Psychology', icon: Icons.psychology, bookCount: 75),
  Category(name: 'Religion', icon: Icons.book, bookCount: 90),
  Category(name: 'Romance', icon: Icons.favorite, bookCount: 187),
  Category(name: 'Science', icon: Icons.science, bookCount: 130),
  Category(name: 'Science Fiction', icon: Icons.science, bookCount: 115),
  Category(name: 'Self-Help', icon: Icons.self_improvement, bookCount: 95),
  Category(name: 'Social Science', icon: Icons.people, bookCount: 85),
  Category(name: 'Sports & Recreation', icon: Icons.sports, bookCount: 70),
  Category(name: 'Travel', icon: Icons.travel_explore, bookCount: 80),
  Category(name: 'True Crime', icon: Icons.gavel, bookCount: 50),
];

final Map<String, Color> categoryColorMap = {
  'Action & Adventure': Colors.red,
  'Art': Colors.orange,
  'Biography & Autobiography': Colors.yellow,
  'Business & Economics': Colors.green,
  'Comics & Graphic Novels': Colors.teal,
  'Computers': Colors.cyan,
  'Cooking': Colors.blue,
  'Drama': Colors.indigo,
  'Family & Relationships': Colors.purple,
  'Fantasy': Colors.pink,
  'Fiction': Colors.brown,
  'Health & Fitness': Colors.redAccent,
  'History': Colors.orangeAccent,
  'Horror': Colors.yellowAccent,
  'Humor': Colors.greenAccent,
  'Mystery': Colors.tealAccent,
  'Philosophy': Colors.cyanAccent,
  'Poetry': Colors.blueAccent,
  'Psychology': Colors.indigoAccent,
  'Religion': Colors.purpleAccent,
  'Romance': Colors.pinkAccent,
  'Science': Colors.lime,
  'Science Fiction': Colors.limeAccent,
  'Self-Help': Colors.amber,
  'Social Science': Colors.amberAccent,
  'Sports & Recreation': Colors.lightGreen,
  'Travel': Colors.lightGreenAccent,
  'True Crime': Colors.deepOrange,
};