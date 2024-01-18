import 'package:flutter/material.dart';
import 'package:front/controller/chat_contoller.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/global/util.dart';
import 'package:front/pages/pages.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';

class ChooseStudentView extends StatefulWidget {
  const ChooseStudentView({
    super.key,
  });

  @override
  State<ChooseStudentView> createState() => _ChooseStudentViewState();
}

class _ChooseStudentViewState extends State<ChooseStudentView> {
  final controller = Get.put(ChatController());
  void select(String id) {
    if (!controller.selectedStudents.contains(id)) {
      controller.selectedStudents.add(id);
    } else {
      controller.selectedStudents.remove(id);
    }
  }

  final GlobalKey<ScaffoldState> chooseStudentKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Util util = Util();
    return Scaffold(
      key: chooseStudentKey,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  chooseStudentKey.currentState?.openDrawer();
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
          height: MediaQuery.of(context).size.height ,
          padding: const EdgeInsets.only(right: medium, left: medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    space13,
                    MainButton(
                      color: searchColor,
                      shadowColor: searchShadowColor,
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: StudentSearchDelegate());
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.search),
                          space13,
                          Text(search)
                        ],
                      ),
                    ),
                    space13,
                    Text(
                      chooseStudent,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold, letterSpacing: -0.02),
                    ),
                    space13,
                    Text(controller.choseGroup.value),
                    space22,
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    SizedBox(
                        child: Obx(
                      () => GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.75),
                          itemCount: controller.searchedUsers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  select(controller.searchedUsers[index].sId!);
                                },
                                child: Obx(
                                  () => ChooseStudentCard(
                                    data: controller.searchedUsers[index],
                                    index: index,
                                    active: controller.selectedStudents
                                        .where((p0) =>
                                            p0 ==
                                            controller.searchedUsers[index].sId)
                                        .isNotEmpty,
                                  ),
                                ));
                          }),
                    )),
                    Obx(() => controller.selectedStudents.isNotEmpty
                        ? Positioned(
                            bottom: appbarHeight / 2,
                            right: 0,
                            left: 0,
                            child: MainButton(
                              color: green,
                              textColor: white,
                              shadowColor: greenShadow,
                              onPressed: () async {
                                bool res =
                                    await controller.create(ChatTypes.TEAM);

                                if (res) {
                                  util.mainAlertDialog(
                                      'Пүүх!',
                                      'Та ${controller.choseGroup} хичээлийн багийн чат амжилттай үүслээ. ',
                                      context,
                                      AlertType.success,
                                      controller.createStep.value);
                                }
                              },
                              label: addMember,
                            ))
                        : Container(
                            width: 50,
                            height: 50,
                            color: Colors.red,
                          ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
