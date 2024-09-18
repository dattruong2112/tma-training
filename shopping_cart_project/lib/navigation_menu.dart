import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_cart_project/pages/cart_page.dart';
import 'package:shopping_cart_project/pages/favorite_page.dart';
import 'package:shopping_cart_project/pages/order_page.dart';
import 'package:shopping_cart_project/pages/profile_page.dart';
import 'package:shopping_cart_project/pages/store_page.dart';
import 'pages/homescreen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 75,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Favorite'),
            NavigationDestination(icon: Icon(Iconsax.shopping_cart), label: 'Cart'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StorePage(),
    const FavoritePage(),
    CartPage(),
    const ProfilePage(),
    const OrderPage(orderId: '', orderDateTime: '')
  ];
}
