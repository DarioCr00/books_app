// ignore_for_file: use_super_parameters

import 'package:books_app/pages/book_page.dart';
import 'package:books_app/widgets/favourite_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:books_app/model/book.dart';

class PopularBooksWidget extends StatelessWidget {
  final List<Book> books;

  const PopularBooksWidget({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //grid is not scrollable and its size its determined by the content
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      //defining the layout
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6, 
        mainAxisSpacing: 10, //spacing between rows
        crossAxisSpacing: 10, //spacing between col
      ),
      itemCount: books.length,
      //build each grid item
      itemBuilder: (context, index) {
        final book = books[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => BookPage(book: book),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: book.thumbnail!,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 150, //set the height for the image
                fit: BoxFit.cover, //cover the entire area
              ),
              const SizedBox(height: 5),
              Text(
                book.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis, //truncate the title if it overflows
              ),
              const SizedBox(height: 5),
              Text(
                book.subtitle ?? '',
                style: const TextStyle(
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              FavouriteButtonWidget(
                book: book,
                onFavouriteChanged: (isFavourite) {
                      },
              ),
            ],
          ),
        );
      }, 
    );
  }
}