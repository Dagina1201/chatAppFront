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
                icon: Icon(Icons.menu)),
            Image.asset(imageLogo),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                imageLogo,
                width: 53,
                height: 53,
              ),
            )
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
                          Get.toNamed(Routes.chooseGroup);
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
              // if (controller.chats.isNotEmpty && !isTeam)
              //   ...controller.chats.map((e) {
              //     int index = chatsValues.indexOf(e);
              //     return MainContainer(
              //         margin: EdgeInsets.only(
              //             bottom: index == chatsValues.length - 1 ? 0 : 4),
              //         color: searchColor,
              //         padding: EdgeInsets.symmetric(
              //             vertical: regular, horizontal: large),
              //         borderRadius: index == chatsValues.length - 1
              //             ? BorderRadius.only(
              //                 bottomRight: Radius.circular(borderRadius16),
              //                 bottomLeft: Radius.circular(borderRadius16))
              //             : BorderRadius.circular(0),
              //         shadow: true,
              //         shadowColor: searchShadowColor,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: <Widget>[
              //             Text(
              //               '${e.name}${e.number}_${e.groupNumber ?? ''}',
              //               style: Theme.of(context).textTheme.bodySmall!.copyWith(
              //                   color: placeholderColor, letterSpacing: -0.02),
              //             ),
              //             MainButton(
              //               onPressed: () {
              //                 util.mainAlertDialog(
              //                     'Пүүх!',
              //                     'Та ${e.name}${e.number}_${e.groupNumber ?? ''} хичээлийн групийг амжилттай нэмлээ. ',
              //                     context,
              //                     AlertType.success);
              //               },
              //               color: Colors.transparent,
              //               padding: EdgeInsets.zero,
              //               shadow: false,
              //               child: Row(
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: <Widget>[
              //                   Text(
              //                     add,
              //                     style: Theme.of(context)
              //                         .textTheme
              //                         .bodySmall!
              //                         .copyWith(
              //                           color: orange,
              //                           letterSpacing: -0.02,
              //                         ),
              //                   ),
              //                   space6,
              //                   Container(
              //                       padding: EdgeInsets.all(4),
              //                       decoration: BoxDecoration(
              //                           border: Border.all(color: orange),
              //                           borderRadius: BorderRadius.circular(tiny)),
              //                       child: Icon(
              //                         Icons.add_rounded,
              //                         color: orange,
              //                       ))
              //                 ],
              //               ),
              //             )
              //           ],
              //         ));
              //   }).toList(),
              space32,
              Text(
                chats,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold, letterSpacing: -0.02),
              ),
              space9,
              ...groups.map((e) {
                int index = groups.indexOf(e);
                return StreamBuilder(
                    stream: streamSocket.getResponse,
                    builder: (BuildContext context, AsyncSnapshot snapshop) {
                      // return Text(snapshop.data.toString());
                      return ChatCard(
                        data: e,
                        index: index,
                        onPressed: (v) {
                          print(v);
                        },
                      );
                    });
              }),
              space20
            ],
          ),
        ),
      ),
    );
  }
}
