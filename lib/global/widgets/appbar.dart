import 'package:flutter/material.dart';
import 'package:front/controller/controllers.dart';

import 'package:front/global/global.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';

const double kToolbarHeight = 65.0;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    this.padding = 12.0,
    required this.onTap,
    this.child,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  final double padding;

  final Function() onTap;
  final Widget? child;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(top: MediaQuery.of(context).padding.top + regular),
        padding: const EdgeInsets.symmetric(horizontal: regular),
        child: child ??
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: <Widget>[
                MainButton(
                  width: 32,
                  padding: const EdgeInsets.all(small),
                  onPressed: onTap,
                  // color: Colors.transparent,
                  // shadowColor: Colors.transparent,
                  borderRadius: 100,
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: black,
                  ),
                ),
                const SizedBox()
              ],
            ));
  }
}

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Get.toNamed(Routes.main);
              onTap();
            },
          ),
          ListTile(
            title: const Text(chats),
            onTap: () {
              onTap();
              Get.toNamed(Routes.chat);
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () {
              onTap();
              controller.logout();
            },
          ),
        ],
      ),
    );
  }
}
