import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_cart_project/models/users.dart';
import 'package:shopping_cart_project/service/user_service.dart';
import 'package:shopping_cart_project/widget/navigation_menu.dart';
import 'package:shopping_cart_project/widget/custom_scaffold.dart';
import 'package:shopping_cart_project/widget/sized_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserService userService = UserService();
  User? user;
  final int userId = 2;

  @override
  void initState() {
    super.initState();
    fetchUserDetails(userId);
  }

  void fetchUserDetails(int userId) async {
    User? fetchedUser = await userService.getUserIdBy(userId);

    if (fetchedUser != null) {
      setState(() {
        user = fetchedUser;
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
        title: 'Profile',
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Icon(Iconsax.profile_circle5, color: Colors.black, size: 130,),
                  ),
                ),
                10.0.vertical(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 3),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Full Name'),
                        subtitle: Text(user!.name),
                        leading: const Icon(Iconsax.personalcard),
                        trailing: const Icon(Iconsax.arrow_right),
                      ),
                      ListTile(
                        title: const Text('Role'),
                        subtitle: Text(user!.role),
                        leading: const Icon(Iconsax.user_tag),
                        trailing: const Icon(Iconsax.arrow_right),
                      ),
                      ListTile(
                        title: const Text('Bio'),
                        subtitle: Text(user?.bio ?? 'N/A'),
                        leading: const Icon(Iconsax.info_circle),
                        trailing: const Icon(Iconsax.arrow_right),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
