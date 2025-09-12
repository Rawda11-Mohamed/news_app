class Article {
  final String id;
  final String title;
  final String content;
  final String author;
  final String date;
  final String imageUrl;
  final String category;
  final bool isBookmarked;

  const Article({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.category,
    this.isBookmarked = false,
  });

  Article copyWith({
    String? id,
    String? title,
    String? content,
    String? author,
    String? date,
    String? imageUrl,
    String? category,
    bool? isBookmarked,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      date: date ?? this.date,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'date': date,
      'imageUrl': imageUrl,
      'category': category,
      'isBookmarked': isBookmarked,
    };
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      author: json['author'] ?? '',
      date: json['date'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }


}

