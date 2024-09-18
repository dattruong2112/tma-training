import 'package:shopping_cart_project/models/foods.dart';

class Order {
  final int orderId;
  final String orderDateTime;
  final List<Food> foods;

  Order(
      {required this.orderId,
      required this.orderDateTime,
      required this.foods});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      orderDateTime: json['orderDateTime'],
      foods:
          (json['foods'] as List).map((food) => Food.fromJson(food)).toList(),
    );
  }
  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "orderDateTime": orderDateTime,
  };
}
