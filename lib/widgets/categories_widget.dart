// ignore_for_file: use_super_parameters, use_build_context_synchronously, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:books_app/controller/main_controller.dart';
import 'package:books_app/model/categories.dart';
import 'package:books_app/widgets/category_book_list_widget.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final MainController mainController;

  CategoriesWidget({required this.mainController});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final color = categoryColorMap[category.name] ?? Colors.grey;
          return CategoryItem(
            category: category,
            color: color,
            onTap: () async {
              final books = await mainController.searchBooksByCategory(category.name);
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => BookListWidget(books: books, categoryName: category.name)
                ),
              );
            }
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;
  final Color color;
  final VoidCallback onTap;

  const CategoryItem({Key? key, required this.category, required this.color, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(category.icon, size: 30, color: color),
          ),
          const SizedBox(height: 10),
          Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(color: color),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            '${category.bookCount} books',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }
}