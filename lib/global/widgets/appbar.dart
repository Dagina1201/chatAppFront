import 'package:cached_network_image/cached_network_image.dart';
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
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + medium,
            left: tiny,
            right: tiny,
            bottom: MediaQuery.of(context).padding.bottom + medium,
          ),
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Obx(() => RoundedImage(
                          asset: imageLogo,
                          height: 60,
                          width: 60,
                          borderRadius: borderRadius15,
                          url: controller.user.value?.profileImg,
                        )),
                    space13,
                    Text(
                      hello,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    space4,
                    Obx(
                      () => Text(
                        removeUrl(controller.user.value!.username ?? ''),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text(home),
                    onTap: () {
                      Get.toNamed(Routes.main);
                      onTap();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text(chats),
                    onTap: () {
                      onTap();
                      Get.toNamed(Routes.chat);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text(info),
                    onTap: () {
                      onTap();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.money),
                    title: const Text(hustle),
                    onTap: () {
                      onTap();
                    },
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: tall),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: grayBlue.withOpacity(0.7)))),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(help),
                      onTap: () {
                        onTap();
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(logout),
                    onTap: () {
                      onTap();
                      controller.logout();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
