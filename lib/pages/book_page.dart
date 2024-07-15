// ignore_for_file: use_super_parameters

import 'package:books_app/widgets/favourite_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:books_app/model/book.dart';


//widget containing further informations about a specific book
class BookPage extends StatelessWidget {
  final Book book;

  const BookPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String description = book.description ?? 'No description available';
    String ratings = book.averageRating != null ? book.averageRating.toString() : 'No ratings available';

    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //aligning children to start of the content
              children: [
                if (book.thumbnail != null)
                  Center(
                    child: Image.network(
                      book.thumbnail!,
                      height: 200,
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        book.authors.join(', '), //joining author's name with commas
                        style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    FavouriteButtonWidget(
                      book: book,
                      onFavouriteChanged: (isFavourite) {
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4, //elevation for shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Container(
                    width: double.infinity, //full width of the parent
                    height: 100,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ratings',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ratings,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                         'Description', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}