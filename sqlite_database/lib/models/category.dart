class Category {
  int? id;
  String category;
  Category({this.id, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      category: map['category'],
    );
  }
}