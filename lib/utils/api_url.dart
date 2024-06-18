import 'package:prova/api/api_key.dart';

String googleBooksApiUrl(String query) {
  final String baseUrl = "https://www.googleapis.com/books/v1/volumes";
  final String fields = "items(volumeInfo(title,subtitle,authors,publisher,publishedDate,description,pageCount,categories,imageLinks,language))";
  return "$baseUrl?q=$query&fields=$fields&key=$apiKey";
}