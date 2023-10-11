import 'package:flutter/material.dart';
import 'package:front/controller/main_controller.dart';
import 'package:front/global/global.dart';
import 'package:front/global/util.dart';
import 'package:front/pages/pages.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final controller = Get.put(MainController());
  final storage = GetStorage();
  Util util = Util();
  List<Widget> views = [
    HomeView()
  ];


  @override
  void initState() {
  
   
    super.initState();

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onTap: () {}, ),
      body: Padding(
        padding: const  EdgeInsets.symmetric(horizontal: medium),
        child: Obx(
            () => 
                 views[controller.currentIndex.value]
                ,
          ),
      )
    );
    // return GetBuilder<MainController>(
    //   init: MainController(),
    //   builder: (controller) => controller.obx(
    //       onLoading: const SplashView(),
    //       onError: (error) => Stack(
    //             children: [
    //               // const SplashView(),

    //               Text(error.toString())
    //             ],
    //           ), (user) {

    //     return Scaffold(
         
    //       body: Obx(
    //         () => 
    //              views[controller.currentIndex.value]
    //             ,
    //       ),
         
    //     );
    //   }),
    // );
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
