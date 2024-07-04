// ignore_for_file: use_super_parameters

import 'package:books_app/widgets/favourite_button_widget.dart';
 //import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:books_app/model/book.dart';

class BookRecommendedWidget extends StatelessWidget {
  final Book book;

  const BookRecommendedWidget({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String truncatedDescription = (book.description != null && book.description!.length > 200)
        ? '${book.description!.substring(0, 200)}...'
        : book.description ?? '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(12.0)
      ),      
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BOOK RECOMMENDED',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: book.thumbnail!,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      book.subtitle ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      truncatedDescription,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FavouriteButtonWidget(book: book),
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}