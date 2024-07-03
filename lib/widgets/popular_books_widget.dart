// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:books_app/model/book.dart';

class PopularBooksWidget extends StatelessWidget {
  final List<Book> books;

  const PopularBooksWidget({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: book.thumbnail!,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            Text(
              book.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
          ],
        );
      },
    );
  }
}