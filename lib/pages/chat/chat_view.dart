import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front/controller/controllers.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/global/util.dart';
import 'package:front/pages/main/main.dart';
import 'package:front/provider/provider.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool isTeam = false;
  final controller = Get.put(ChatController());
  List<Chat> chatsValues = [];
  Util util = Util();
  final mainController = Get.put(MainController());
  final GlobalKey<ScaffoldState> chatKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getChats();
  }

  void getChats() {
    if (isTeam) {
      controller.getChats(ChatTypes.TEAM);
    } else {
      controller.getChats(ChatTypes.GROUP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: chatKey,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  chatKey.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu)),
            Image.asset(imageLogo),
            Obx(() => RoundedImage(
                  asset: imageLogo,
                  width: 40,
                  height: 40,
                  url: mainController.user.value!.profileImg,
                ))
          ],
        ),
      ),
      drawer: MainDrawer(onTap: () {
        chatKey.currentState?.closeDrawer();
      }),
      body: Container(
        height: MediaQuery.of(context).size.height -
            huge -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(right: medium, left: medium),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              space20,
              MainContainer(
                color: waterBlue,
                shadow: true,
                shadowColor: waterBlueShadow,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: mini),
                            decoration: BoxDecoration(
                                border: isTeam
                                    ? const Border()
                                    : const Border(
                                        bottom: BorderSide(color: orange))),
                            child: Text(lesson,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: isTeam ? black : orange,
                                      letterSpacing: -0.02,
                                    )),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (isTeam) {
                          setState(() {
                            isTeam = !isTeam;
                          });
                          getChats();
                        }
                      },
                    )),
                    Expanded(
                        child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: mini),
                            decoration: BoxDecoration(
                                border: !isTeam
                                    ? const Border()
                                    : const Border(
                                        bottom: BorderSide(color: orange))),
                            child: Text(team,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: !isTeam ? black : orange,
                                      letterSpacing: -0.02,
                                    )),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (!isTeam) {
                          setState(() {
                            isTeam = !isTeam;
                          });
                          getChats();
                        }
                      },
                    )),
                  ],
                ),
              ),
              space20,
              isTeam
                  ? MainContainer(
                      color: Colors.transparent,
                      padding: EdgeInsets.zero,
                      shadow: false,
                      child: MainButton(
                        onPressed: () {
                          controller.search(ChatTypes.GROUP, " ");
                          Get.toNamed(Routes.chooseGroup);
                          controller.createStep.value = 1;
                        },
                        color: searchColor,
                        shadowColor: searchShadowColor,
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(mini),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: searchTextGray, width: 2),
                                  borderRadius: BorderRadius.circular(small)),
                              child: Icon(
                                Icons.add,
                                color: searchTextGray,
                                size: 16,
                              ),
                            ),
                            space20,
                            Txt(
                              text: createTeamChat,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: searchTextGray,
                                      letterSpacing: -0.02),
                            )
                          ],
                        ),
                      ))
                  : MainButton(
                      color: searchColor,
                      shadowColor: searchShadowColor,
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: JoinChatSearchDelegate());
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.search),
                          space13,
                          Flexible(
                              child: Txt(
                            text: lessonCodeGroupNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: placeholderColor,
                                    letterSpacing: -0.02),
                          ))
                        ],
                      ),
                    ),
              space4,
              space32,
              Text(
                chats,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold, letterSpacing: -0.02),
              ),
              space9,
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.chats.length,
                    itemBuilder: (context, index) => StreamBuilder(
                        stream: streamSocket.getResponse,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshop) {
                          return ChatCard(
                            data: controller.chats[index],
                            index: index,
                            onPressed: (v) {
                              controller.join(controller.chats[index].sId!);
                              controller.connect(controller.chats[index].sId!);
                            },
                          );
                        }),
                  )),
              space20
            ],
          ),
        ),
      ),
    );
  }
}
