import 'package:flutter/material.dart';
import 'package:shopping_cart_project/widget/navigation_menu.dart';
import 'package:shopping_cart_project/pages/intro_page.dart';
import 'package:shopping_cart_project/pages/profile_page.dart';
import 'package:shopping_cart_project/pages/sign_in_page.dart';
import 'package:shopping_cart_project/pages/sign_up_page.dart';
import 'package:shopping_cart_project/pages/store_page.dart';
import 'package:shopping_cart_project/widget/side_menu.dart';
import 'package:shopping_cart_project/widget/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      title: 'Flutter Demo',
      home: const WelcomeScreen(),
      routes: {
        '/homepage': (context) => const NavigationMenu(),
        '/profile_page': (context) => const ProfilePage(),
        '/sign_in_page': (context) => const SignInScreen(),
        '/sign_up_page': (context) => const SignUpScreen(),
        '/side_menu': (context) => const SideMenu(),
        '/store_page': (context) => const StorePage(),
        '/intro_page': (context) => const WelcomeScreen(),
      },
    );
  }
}