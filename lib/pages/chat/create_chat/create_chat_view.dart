import 'package:flutter/material.dart';
import 'package:front/controller/chat_container.dart';
import 'package:front/global/constant/constant.dart';
import 'package:front/global/global.dart';
import 'package:front/pages/chat/chat.dart';
import 'package:get/get.dart';

class CreateChatView extends StatefulWidget {
  const CreateChatView({super.key});

  @override
  State<CreateChatView> createState() => _CreateChatViewState();
}

class _CreateChatViewState extends State<CreateChatView> {
  final pages = [
ChooseGroupWidget(data: groups),
ChooseStudentWidget(data: users),

  ];

  final controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
        Obx(() => Text(createStepTexts[controller.createStep.value], style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold, letterSpacing: -0.02),),
        ),
        if(controller.choseGroup.value != "") 
        space13,
        Obx(() => controller.choseGroup.value != "" ? Text(controller.choseGroup.value) : const SizedBox()),
        space22,
        Obx(() => pages[controller.createStep.value]),
      ],
    );
  }
}