import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_cart_project/models/foods.dart';
import 'package:shopping_cart_project/widget/navigation_menu.dart';
import 'package:shopping_cart_project/pages/detail_page.dart';
import 'package:shopping_cart_project/service/food_service.dart';

class CategoryController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedCategory = 'Foods'.obs;
  var foodList = <Food>[].obs;
  var favoriteItems = <String>[].obs;
  var cartItems = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFoodByCategory();
  }

  void changeCategory(int index) {
    selectedIndex.value = index;
    List<String> categories = [
      'Foods',
      'Fruits',
      'Snacks',
      'Drinks',
      'Desserts'
    ];
    selectedCategory.value = categories[index];
    fetchFoodByCategory();
  }

  void fetchFoodByCategory() async {
    List<Food> foods =
        await FoodService().getFoodByCategory(selectedCategory.value);
    foodList.value = foods;
  }

  //put favorite
  void toggleFavorite(Food food) {
    if (favoriteItems.contains(food.id)) {
      favoriteItems.remove(food.id);
    } else {
      favoriteItems.add(food.id);
    }
  }

  bool isFavorite(Food food) {
    return favoriteItems.contains(food.id);
  }

  void addToCart(Food food) {
    if (!cartItems.contains(food.id)) {
      cartItems.add(food.id);
    }
  }

  void removeFromCart(Food food) {
    cartItems.remove(food.id);
  }

  bool isInCart(Food food) {
    return cartItems.contains(food.id);
  }
}

Widget header() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Material(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          child: GestureDetector(
            child: Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Iconsax.menu_14, color: Colors.black),
                ),
              );
            }),
          ),
        ),
        const Spacer(),
        const Icon(Icons.location_on, color: Colors.blueAccent),
        const Text(
          ' Ho Chi Minh City',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'SpaceGrotesk',
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.find<NavigationController>().selectedIndex.value = 4;
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Iconsax.profile_circle5,
                color: Colors.black,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget title() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi Danh',
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontFamily: 'SpaceGrotesk'),
        ),
        Text(
          'Find your food',
          style: TextStyle(
              color: Colors.black,
              fontSize: 34,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget search() {
  return Container(
    height: 60,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.fromLTRB(8, 2, 6, 2),
    decoration: BoxDecoration(
      color: Colors.blue[50],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(Iconsax.search_normal, color: Colors.blue),
              hintText: 'Search food',
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontFamily: 'SpaceGrotesk',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget categories() {
  final CategoryController categoryController = Get.put(CategoryController());
  List<String> list = ['Foods', 'Fruits', 'Snacks', 'Drinks', 'Desserts'];
  return SizedBox(
    height: 40,
    child: ListView.builder(
      itemCount: list.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            categoryController.changeCategory(index);
          },
          child: Obx(
            () => Container(
              padding: EdgeInsets.fromLTRB(
                index == 0 ? 16 : 16,
                0,
                index == list.length - 1 ? 16 : 16,
                0,
              ),
              alignment: Alignment.center,
              child: Text(
                list[index],
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 22,
                  color: categoryController.selectedIndex.value == index
                      ? Colors.blueAccent
                      : Colors.grey,
                  fontWeight: categoryController.selectedIndex.value == index
                      ? FontWeight.bold
                      : null,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget gridFood() {
  final CategoryController categoryController = Get.find<CategoryController>();

  return Obx(() {
    List<Food> foods = categoryController.foodList;

    return GridView.builder(
      itemCount: foods.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 261,
      ),
      itemBuilder: (context, index) {
        Food food = foods[index];
        bool isFavorite = categoryController.isFavorite(food);

        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailPage(food: food);
            }));
          },
          child: Container(
            height: 261,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: Image.network(
                          food.image,
                          width: 120,
                          height: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        food.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            '${food.cookingTime} mins',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const Spacer(),
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            food.rate.toString(),
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '\$${food.price}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      FoodController().toggleFavorite(food);
                    },
                    child: Icon(
                      isFavorite ? Iconsax.heart5 : Iconsax.heart_add,
                      color: isFavorite ? Colors.red : Colors.black54,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Material(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Iconsax.add, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  });
}
