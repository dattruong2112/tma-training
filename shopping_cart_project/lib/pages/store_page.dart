import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart_project/widget/navigation_menu.dart';
import 'package:shopping_cart_project/widget/sized_box.dart';
import 'package:shopping_cart_project/widget/widgets.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  // List<Food> food = [];
  //
  // @override
  // void initState() {
  //   fetchFood();
  //   super.initState();
  // }
  //
  // Future<void> fetchFood() async {
  //   food = await FoodService().getFood();
  //   setState(() {
  //
  //   });
  // }

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
            'Canteen Menu',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            categories(),
            const Divider(color: Colors.black, thickness: 1,),
            20.0.vertical(),
            gridFood(),
          ],
        ),
      ),
    );
  }
}
