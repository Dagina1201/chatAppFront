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
ChooseGroupWidget(data: groups)
  ];
  final controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => pages[controller.createStep.value]));
  }
}