import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart_project/models/foods.dart';
import 'package:shopping_cart_project/navigation_menu.dart';
import 'package:shopping_cart_project/pages/order_page.dart';
import 'package:shopping_cart_project/service/food_service.dart';

class CartController extends GetxController {
  var cartItems = <Food>[].obs;
  var quantity = <String, int>{}.obs;

  void addToCart(Food food, int quantityToAdd) {
    if (cartItems.contains(food)) {
      int currentQuantity = quantity[food.id] ?? 1;
      quantity[food.id] = currentQuantity + quantityToAdd;
    } else {
      cartItems.add(food);
      quantity[food.id] = quantityToAdd;
    }
  }
}

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<NavigationController>().selectedIndex.value = 0;
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cart',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () {
                  if (cartController.cartItems.isEmpty) {
                    return const Center(
                      child: Text(
                        'Your cart is empty.',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      child: ListView.builder(
                        itemCount: cartController.cartItems.length,
                        itemBuilder: (context, index) {
                          final food = cartController.cartItems[index];
                          return Column(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 3)),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  leading: Image.network(food.image,
                                      width: 60, height: 60),
                                  title: Text(
                                    food.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'SpaceGrotesk'),
                                  ),
                                  subtitle: Text(
                                    '\$${food.price}',
                                    style: const TextStyle(
                                        fontSize: 16, fontFamily: 'Poppins'),
                                  ),
                                  trailing: Text(
                                    'x${cartController.quantity[food.id] ?? 1}',
                                    style: const TextStyle(
                                        fontSize: 16, fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            // Checkout button at the bottom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final response = await FoodService()
                        .addToOrder(cartController.cartItems);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OrderPage(
                                orderId: "${response?["orderId"]}",
                                orderDateTime: response?["orderDateTime"])));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
