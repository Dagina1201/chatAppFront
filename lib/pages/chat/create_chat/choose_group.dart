import 'package:flutter/material.dart';
import 'package:front/controller/chat_contoller.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';

class ChooseGroupWidget extends StatefulWidget {
  const ChooseGroupWidget({super.key});

  @override
  State<ChooseGroupWidget> createState() => _ChooseGroupWidgetState();
}

class _ChooseGroupWidgetState extends State<ChooseGroupWidget> {
  final GlobalKey<ScaffoldState> chooseGroupKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    return Scaffold(
      key: chooseGroupKey,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  chooseGroupKey.currentState?.openDrawer();
                },
                icon: Icon(Icons.menu)),
            Image.asset(imageLogo),
            const RoundedImage(
              asset: imageLogo,
              width: 53,
              height: 53,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(right: medium, left: medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space13,
              MainButton(
                color: searchColor,
                shadowColor: searchShadowColor,
                onPressed: () {
                  showSearch(context: context, delegate: ChatSearchDelegate());
                },
                child: Row(
                  children: <Widget>[Icon(Icons.search), space13, Text(search)],
                ),
              ),
              space13,
              Text(
                chooseGroup,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold, letterSpacing: -0.02),
              ),
              space13,
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Obx(() => GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 0.75),
                      itemCount: controller.searchedChat.length,
                      itemBuilder: (BuildContext context, int index) {
                        String name =
                            '${controller.searchedChat[index].nickname}';
                        return GestureDetector(
                            onTap: () {
                              controller.choseGroup.value = name;
                              controller.choseGroupId.value =
                                  controller.searchedChat[index].sId!;
                              Get.toNamed(Routes.chooseStudent);
                              controller.createStep.value = 2;
                            },
                            child: ChooseGroupCard(
                                name: name,
                                uri: controller.searchedChat[index].img ??
                                    "https://www.ufe.edu.mn/image/%D0%BB%D0%BE%D0%B3%D0%BE%20%D0%B1%D0%BE%D1%81%D0%BE%D0%BE.png"));
                      }))),
            ],
          ),
        ),
      ),
    );
  }
}
