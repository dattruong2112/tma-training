import 'package:flutter/material.dart';
import 'package:shopping_cart_project/models/foods.dart';
import 'package:shopping_cart_project/side_menu.dart';
import 'package:shopping_cart_project/widget/sized_box.dart';
import 'package:shopping_cart_project/widget/theme.dart';
import '../service/food_service.dart';
import '../widget/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Food> food = [];

   @override
  void initState() {
     fetchFood();
    super.initState();
  }

  Future<void> fetchFood() async {
     food = await FoodService().getFood();
     setState(() {

     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightColorScheme.onPrimary,
      drawer: const SideMenu(),
      body: ListView(
        children: [
          16.0.vertical(),
          header(),
          30.0.vertical(),
          title(),
          20.0.vertical(),
          search(),
          30.0.vertical(),
          categories(),
          20.0.vertical(),
          gridFood(food),
        ],
      ),
    );
  }
}

