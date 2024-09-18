import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_cart_project/navigation_menu.dart';
import 'package:shopping_cart_project/pages/detail_page.dart';
import 'package:shopping_cart_project/widget/custom_scaffold.dart';
import 'package:shopping_cart_project/widget/sized_box.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                  padding: EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Icon(CupertinoIcons.person_fill, color: Colors.black, size: 100,),
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
                  child: const Column(
                    children: [
                      ListTile(
                        title: Text('First Name'),
                        subtitle: Text('Danh'),
                        leading: Icon(Iconsax.personalcard),
                        trailing: Icon(Iconsax.arrow_right_3),
                      ),
                      ListTile(
                        title: Text('Last Name'),
                        subtitle: Text('Danh'),
                        leading: Icon(Iconsax.user_tag),
                        trailing: Icon(Iconsax.arrow_right_3),
                      ),
                      ListTile(
                        title: Text('Your Bio'),
                        subtitle: Text('Danh'),
                        leading: Icon(Iconsax.info_circle),
                        trailing: Icon(Iconsax.arrow_right_3),
                      ),
                      ListTile(
                        title: Text('Birthday'),
                        subtitle: Text('8/3/2003'),
                        leading: Icon(Iconsax.calendar_1),
                        trailing: Icon(Iconsax.arrow_right_3),
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
