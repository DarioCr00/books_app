import 'package:flutter/material.dart';
import 'package:books_app/controller/main_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookSearchPage(),
    );
  }
}

class BookSearchPage extends StatefulWidget {
  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final MainController _mainController = MainController();
  final TextEditingController _searchController = TextEditingController();
  List<Book> _books = [];
  bool _isLoading = false;
  String _errorMessage = '';

  void _searchBooks() async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        final books = await _mainController.fetchBooks(query);
        setState(() {
          _books = books;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for books',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchBooks,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_isLoading)
              CircularProgressIndicator()
            else if (_errorMessage.isNotEmpty)
              Text(_errorMessage, style: TextStyle(color: Colors.red))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final book = _books[index];
                    final thumbnailUrl = book.thumbnail;
                    return ListTile(
                      leading: thumbnailUrl != null
                          ? CachedNetworkImage(
                              imageUrl: thumbnailUrl,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) {
                                print('Error loading image: $thumbnailUrl');
                                return Icon(Icons.error);
                              },
                            )
                          : Icon(Icons.book),
                      title: Text(book.title),
                      subtitle: Text(book.subtitle ?? ''),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}