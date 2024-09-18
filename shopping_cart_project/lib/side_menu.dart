import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_cart_project/navigation_menu.dart';
import 'package:shopping_cart_project/widget/info_card.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final NavigationController navigationController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
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
                child: const ListTile(
                  leading: SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(Iconsax.home, size: 24),
                  ),
                  title: Text('Home page', style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Regular'),),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigationController.selectedIndex.value = 1;
                  Navigator.of(context).pop();
                },
                child: const ListTile(
                  leading: SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(Iconsax.shop, size: 24),
                  ),
                  title: Text('Store page', style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Regular'),),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigationController.selectedIndex.value = 2;
                  Navigator.of(context).pop();
                },
                child: const ListTile(
                  leading: SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(Iconsax.heart, size: 24),
                  ),
                  title: Text('Favorite page', style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Regular'),),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigationController.selectedIndex.value = 3;
                  Navigator.of(context).pop();
                },
                child: const ListTile(
                  leading: SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(Iconsax.shopping_cart, size: 24),
                  ),
                  title: Text('Checkout page', style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Regular'),),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigationController.selectedIndex.value = 4;
                  Navigator.of(context).pop();
                },
                child: const ListTile(
                  leading: SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(Iconsax.user, size: 24),
                  ),
                  title: Text('History page', style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Regular'),),
                ),
              ),
              const Divider(thickness: 1, color: Colors.black,),
              GestureDetector(
                onTap: () {},
                child: const ListTile(
                  leading: SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(Iconsax.logout, size: 24),
                  ),
                  title: Text('Switch theme', style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Regular'),),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/intro_page');
                },
                child: const ListTile(
                  leading: SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(Iconsax.logout, size: 24),
                  ),
                  title: Text('Log out', style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Regular'),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
