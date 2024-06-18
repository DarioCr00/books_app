import 'package:prova/api/api_key.dart';

String googleBooksApiUrl(String query) {
  final String baseUrl = "https://www.google.com/books/v1/volumes";
  final String fields = "items(volumeInfo(title,authors,publisher,publishedDate,description,pageCount,categories,averageRating,ratingCount,imageLinks,language))";
  return "$baseUrl?q=$query&fields=$fields&key=$apiKey";
}