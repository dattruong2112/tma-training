import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart_project/models/foods.dart';
import 'package:shopping_cart_project/navigation_menu.dart';
import 'package:shopping_cart_project/pages/detail_page.dart';
import 'package:shopping_cart_project/widget/custom_scaffold.dart';
import 'package:shopping_cart_project/widget/widgets.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Food> food = [];
    final CategoryController categoryController =
        Get.find<CategoryController>();

    List<Food> favoriteFoods = food.where((food) {
      return categoryController.favoriteItems.contains(food.id);
    }).toList();
    return WillPopScope(
        onWillPop: () async {
          Get.find<NavigationController>().selectedIndex.value = 0;
          return false;
        },
        child: CustomPage(
          title: 'Favorites',
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              itemCount: favoriteFoods.length,
              itemBuilder: (context, index) {
                Food food = favoriteFoods[index];
                return Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 3),
                      blurRadius: 1,
                    ),
                  ]),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image.asset(food.image,
                            width: 60, height: 60, fit: BoxFit.cover),
                        title: Text(
                          food.name,
                          style: const TextStyle(fontFamily: 'Poppins'),
                        ),
                        subtitle: Text(
                          '\$${food.price}',
                          style: const TextStyle(fontFamily: 'SpaceGrotesk'),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                            size: 26,
                          ),
                          onPressed: () {
                            categoryController.toggleFavorite(food);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(food: food)),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
