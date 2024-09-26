import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart_project/models/foods.dart';
import 'package:shopping_cart_project/widget/navigation_menu.dart';
import 'package:shopping_cart_project/service/food_service.dart';
import 'package:shopping_cart_project/widget/custom_scaffold.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Food> food = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchFoodByFavorite();
  }

  Future<void> fetchFoodByFavorite() async {
    try {
      food = await FoodService().getFoodByFavorite();
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<NavigationController>().selectedIndex.value = 0;
        return false;
      },
      child: CustomPage(
        title: 'Favorites',
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : hasError
                  ? const Center(child: Text('Failed to load favorites.'))
                  : food.isEmpty
                      ? const Center(
                          child: Text(
                            'No favorite foods found.',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        )
                      : ListView.builder(
                          itemCount: food.length,
                          itemBuilder: (context, index) {
                            Food favoriteFood = food[index];
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
                                    leading: Image.network(
                                      favoriteFood.image,
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(
                                      favoriteFood.name,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins'),
                                    ),
                                    subtitle: Text(
                                      '\$${favoriteFood.price}',
                                      style: const TextStyle(
                                          fontFamily: 'SpaceGrotesk'),
                                    ),
                                    // trailing: IconButton(
                                    //   icon: const Icon(
                                    //     Icons.remove_circle,
                                    //     color: Colors.red,
                                    //     size: 26,
                                    //   ),
                                    //   onPressed: () {
                                    //     foodController.toggleFavorite(favoriteFood);
                                    //   },
                                    // ),
                                    // onTap: () {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           DetailPage(food: favoriteFood),
                                    //     ),
                                    //   );
                                    // },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
        ),
      ),
    );
  }
}
