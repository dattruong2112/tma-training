class Book {
  int? id;
  String title;
  String description;
  String category;
  Book(
      {this.id,
        required this.title,
        required this.description,
        required this.category});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
    );
  }
}