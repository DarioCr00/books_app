class Book { //model used to structure data obtained from the API
  final String title;
  final String? subtitle;
  final List<String> authors;
  final String? description;
  final double? averageRating;
  final String? thumbnail;

  Book({required this.title, this.subtitle, required this.authors, this.description, this.averageRating, this.thumbnail});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      subtitle: json['subtitle'],
      authors: (json['authors'] as List<dynamic>?)?.map((author) => author as String).toList() ?? [],
      description: json['description'],
      averageRating: json['averageRating']?.toDouble(),
      thumbnail: json['imageLinks'] != null ? json['imageLinks']['thumbnail'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'authors': authors,
      'description': description,
      'averageRating': averageRating,
      'imageLinks': {
        'thumbnail': thumbnail,
      }
    };
  }
}