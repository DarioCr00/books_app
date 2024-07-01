class Book {
  final String title;
  final String? subtitle;
  final String? thumbnail;

  Book({required this.title, this.subtitle, this.thumbnail});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      subtitle: json['subtitle'],
      thumbnail: json['imageLinks'] != null ? json['imageLinks']['thumbnail'] : null,
    );
  }
}