class Book {
  final String title;
  final String? subtitle;
  final String? description;
  //final double popular;
  final String? thumbnail;

  Book({required this.title, this.subtitle, this.description, /*required this.popular,*/ this.thumbnail});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      //popular: json['averageRating'],
      thumbnail: json['imageLinks'] != null ? json['imageLinks']['thumbnail'] : null,
    );
  }
}