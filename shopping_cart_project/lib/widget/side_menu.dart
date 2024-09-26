import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_cart_project/widget/navigation_menu.dart';
import 'package:shopping_cart_project/widget/custom_list_title.dart';
import 'package:shopping_cart_project/widget/info_card.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final NavigationController navigationController =
      Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        width: 288,
        height: double.infinity,
        // color: const Color(0xFF17203A),

        child: SafeArea(
          child: Column(
            children: [
              const InfoCard(
                name: 'Danh',
                role: 'Manager',
              ),
              GestureDetector(
                onTap: () {
                  navigationController.selectedIndex.value = 0;
                  Navigator.of(context).pop();
                },
                child: const CustomListTitleSideBar(title: 'Home page', icon: Iconsax.home),
              ),
              GestureDetector(
                onTap: () {
                  navigationController.selectedIndex.value = 1;
                  Navigator.of(context).pop();
                },
                child: const CustomListTitleSideBar(title: 'Store page', icon: Iconsax.shop),
              ),
              GestureDetector(
                onTap: () {
                  navigationController.selectedIndex.value = 2;
                  Navigator.of(context).pop();
                },
                child: const CustomListTitleSideBar(title: 'Favorite page', icon: Iconsax.heart),
              ),
              GestureDetector(
                onTap: () {
                  navigationController.selectedIndex.value = 3;
                  Navigator.of(context).pop();
                },
                child: const CustomListTitleSideBar(title: 'Cart page', icon: Iconsax.shopping_cart),
              ),
              GestureDetector(
                onTap: () {
                  navigationController.selectedIndex.value = 4;
                  Navigator.of(context).pop();
                },
                child: const CustomListTitleSideBar(title: 'Profile page', icon: Iconsax.user),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              GestureDetector(
                onTap: () {},
                child: const CustomListTitleSideBar(title: 'Switch Theme', icon: Iconsax.setting),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/intro_page');
                },
                child: const CustomListTitleSideBar(
                  title: 'Logout',
                  icon: Iconsax.logout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
