import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_cart_project/models/foods.dart';
import 'package:get/get.dart';
import 'package:shopping_cart_project/navigation_menu.dart';
import 'package:shopping_cart_project/pages/cart_page.dart';
import 'package:shopping_cart_project/pages/homescreen.dart';
import 'package:shopping_cart_project/service/food_service.dart';
import 'package:shopping_cart_project/widget/sized_box.dart';
import 'package:shopping_cart_project/widget/widgets.dart';

class FoodController extends GetxController {
  final CategoryController categoryController = Get.find<CategoryController>();
  var isFavoriteDetails = false.obs;

  final FoodService foodService = FoodService();

  void toggleFavorite(Food food) async {
    bool newFavoriteStatus = !isFavorite(food);

    if (newFavoriteStatus) {
      categoryController.favoriteItems.add(food.id);
      isFavoriteDetails.value = true;
    } else {
      categoryController.favoriteItems.remove(food.id);
      isFavoriteDetails.value = false;
    }

    try {
      await foodService.favoriteFood(food, newFavoriteStatus);
    } catch (e) {
      print(e);
    }
  }

  bool isFavorite(Food food) {
    return categoryController.favoriteItems.contains(food.id);
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.food});
  final Food food;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  final FoodController foodController = Get.put(FoodController());
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    foodController.isFavoriteDetails.value =
        foodController.isFavorite(widget.food);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: ListView(
        children: [
          20.0.vertical(),
          header(),
          20.0.vertical(),
          image(),
          details(),
        ],
      ),
    );
  }

  Container details() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 32,
                        fontFamily: 'SpaceGrotesk',
                      ),
                    ),
                    Text(
                      '\$${widget.food.price}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(30),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) {
                          quantity -= 1;
                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.remove, color: Colors.white),
                    ),
                    4.0.horizontal(),
                    Text(
                      '$quantity',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                    4.0.horizontal(),
                    IconButton(
                      onPressed: () {
                        quantity += 1;
                        setState(() {});
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                widget.food.rate.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SpaceGrotesk'),
              ),
              const Spacer(),
              const Icon(Icons.fiber_manual_record, color: Colors.red),
              const SizedBox(width: 4),
              Text(
                widget.food.category,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SpaceGrotesk',
                ),
              ),
              const Spacer(),
              const Icon(Icons.access_time_filled, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                widget.food.cookingTime + ' min',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SpaceGrotesk',
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'About Food',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SpaceGrotesk',
                ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.food.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 30),
          Material(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                cartController.addToCart(widget.food, quantity);
                Get.find<NavigationController>().selectedIndex.value = 3;
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: const Text(
                  'Add to Cart',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, color: Colors.white, fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  SizedBox image() {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue[300]!,
                    blurRadius: 16,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(250),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(250),
                child: Image.network(
                  widget.food.image,
                  fit: BoxFit.cover,
                  width: 250,
                  height: 250,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Material(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            child: const BackButton(color: Colors.white),
          ),
          const Spacer(),
          Text(
            'Details Food',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
          ),
          const Spacer(),
          Obx(
            () => Material(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {
                  foodController.toggleFavorite(widget.food);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  child: Icon(
                    foodController.isFavoriteDetails.value
                        ? Iconsax.heart5
                        : Iconsax.heart_add,
                    color: foodController.isFavoriteDetails.value
                        ? Colors.red
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
