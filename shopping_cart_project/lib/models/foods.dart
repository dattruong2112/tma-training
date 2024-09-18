class Food {
  Food({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.rate,
    required this.cookingTime,
    required this.description,
    required this.category,
    required this.quantity,
    this.isFavorite = false,
  });

  String id;
  String image;
  String name;
  double price;
  double rate;
  String cookingTime;
  String description;
  String category;
  int quantity;
  bool isFavorite;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    id: json["id"].toString(),
    image: json["image"],
    name: json["name"],
    price: json["price"],
    category: json["category"],
    rate: json["rate"].toDouble(),
    cookingTime: json["cookingTime"],
    description: json["description"],
    quantity: json["quantity"] ?? 1,
    isFavorite: json["favorite"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "price": price,
    "rate": rate,
    "category": category,
    "cooking_time": cookingTime,
    "description": description,
    "quantity": quantity,
    "is_favorite": isFavorite,
  };
}