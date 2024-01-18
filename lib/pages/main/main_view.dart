import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front/controller/main_controller.dart';
import 'package:front/global/global.dart';
import 'package:front/global/util.dart';
import 'package:front/pages/pages.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainView extends StatefulWidget {
  const MainView({
    super.key,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final controller = Get.put(MainController());
  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> mainKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: mainKey,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    mainKey.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu)),
              Image.asset(
                imageLogo,
                height: 36,
              ),
              Obx(() => RoundedImage(
                  asset: imageLogo,
                  url: controller.user.value?.profileImg,
                  height: 40,
                  width: 40))
            ],
          ),
        ),
        drawer: MainDrawer(onTap: () {
          mainKey.currentState?.closeDrawer();
        }),
        body: Container(
          height: MediaQuery.of(context).size.height -
              huge -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
          padding: EdgeInsets.only(right: medium, left: medium),
          child: HomeView(),
        ));
  }
}

// class InvalidConfigWidget extends StatelessWidget {
//   /// Construct the [InvalidConfigWidget]
//   const InvalidConfigWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//       child: Text(
//           'Make sure you set the correct appId, ${config.appId}, channelId, etc.. in the lib/config/agora.config.dart file.'),
//     );
//   }
// }
