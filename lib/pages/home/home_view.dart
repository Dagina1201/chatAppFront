import 'package:flutter/material.dart';
import 'package:front/controller/chat_contoller.dart';
import 'package:front/controller/controllers.dart';
import 'package:front/data/data.dart';
import 'package:front/global/constant/constant.dart';
import 'package:front/global/global.dart';
import 'package:front/pages/pages.dart';
import 'package:front/provider/provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ChatTypes filteredChatType = chatFilters[0];
  final chatController = Get.put(ChatController());
  final mainController = Get.put(MainController());
  @override
  void initState() {
    chatController.getChats(ChatTypes.ALL);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        space45,
        Obx(
          () => Text(
              'Hello ${mainController.user.value?.username != null ? mainController.user.value!.username! : mainController.user.value?.email ?? ''}', style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),),
        ),
        space9,
        HomeStatusView(
          list: diagramValues,
        ),
        space45,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichTxt(label: [
              '${DateTime.now().day} ${DateFormat.MMMM().format(DateTime.now())}'
            ], text: '$today, '),
            DropdownButton(
              value: filteredChatType,
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: chatFilters.map((ChatTypes items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: dropGray),
                  ),
                );
              }).toList(),
              onChanged: (ChatTypes? v) {
                if (v != null) {
                  setState(() {
                    filteredChatType = v;
                  });
                  chatController.getChats(v);
                }
              },
            ),
          ],
        ),
        space20,
        Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chatController.chats.length,
              itemBuilder: (context, index) => StreamBuilder(
                  stream: streamSocket.getResponse,
                  builder: (BuildContext context, AsyncSnapshot snapshop) {
                    return ChatCard(
                      data: chatController.chats[index],
                      index: index,
                      onPressed: (v) {
                        chatController
                            .getChat(chatController.chats[index].sId!);
                        chatController
                            .connect(chatController.chats[index].sId!);
                      },
                    );
                  }),
            )),
        space20
      ],
    ));
  }
}
