import 'package:flutter/material.dart';
import 'package:front/controller/controllers.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/provider/api.dart';
import 'package:get/get.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key, required this.id});
  final String id;
  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final GlobalKey<ScaffoldState> messageKey = GlobalKey<ScaffoldState>();

  Chat chat = Chat();
  final ctrl = Get.put(ChatController());
  final mainController = Get.put(MainController());
  double dismissible = 0;
  int? dismissibleIndex;
  String? parentMessage;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Chat res = await ctrl.getChatById(widget.id);
    setState(() {
      chat = res;
    });
    // controller.jumpTo(controller.position.maxScrollExtent);
  }

  int messageCount = 0;
  FocusNode inputNode = FocusNode();
  void openKeyboard() {
    FocusScope.of(context).requestFocus(inputNode);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (controller.hasClients) {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    });
    return Scaffold(
      key: messageKey,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(150 + MediaQuery.of(context).padding.top),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius15),
                  bottomRight: Radius.circular(borderRadius15))),
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 12,
              right: 12,
              bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: white,
                      )),
                  MainButton(
                    padding: EdgeInsets.all(8),
                    shadow: false,
                    onPressed: () {},
                    child: const Icon(
                      Icons.message_rounded,
                      size: 20,
                      color: white,
                    ),
                  )
                ],
              ),
              space9,
              Text(
                chat.nickname ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: white, letterSpacing: -0.02),
              ),
              space4,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const AvatarListWidget(),
                  MainButton(
                    shadow: false,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    onPressed: () {
                      controller.jumpTo(controller.position.maxScrollExtent);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: white),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Icon(
                            Icons.add_rounded,
                            color: white,
                            size: 16,
                          ),
                        ),
                        space4,
                        Text(
                          add,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: white),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height -
            huge -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom,
        padding: const EdgeInsets.only(right: medium, left: medium),
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 40),
              child: StreamBuilder(
                  stream: streamSocket.getMessage,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<Message>? allMessage;
                    allMessage = snapshot.data;
                    if (snapshot.data != null &&
                        snapshot.data != Null &&
                        messageCount != (snapshot.data as List).length) {
                      allMessage = snapshot.data;
                      messageCount = (snapshot.data as List).length;
                      if (controller.hasClients) {
                        controller.jumpTo(controller.position.maxScrollExtent);
                      }
                    }

                    return (allMessage != null)
                        ? ListView.builder(
                            controller: controller,
                            shrinkWrap: true,
                            itemCount: allMessage.length,
                            itemBuilder: (context, index) {
                              bool user = allMessage![index].sender?.sId ==
                                  mainController.user.value!.sId!;
                              return GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  openKeyboard();

                                  setState(() {
                                    parentMessage = allMessage![index].sId!;
                                    dismissible = 0;
                                  });
                                },
                                onHorizontalDragUpdate: (details) {
                                  if (details.primaryDelta != null &&
                                      details.primaryDelta! > 0 &&
                                      details.primaryDelta! *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75 <
                                          MediaQuery.of(context).size.width *
                                              0.2) {
                                    setState(() {
                                      dismissibleIndex = index;
                                      dismissible = details.primaryDelta! *
                                          MediaQuery.of(context).size.width *
                                          0.75;
                                    });
                                  }
                                },
                                child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 100),
                                    padding: EdgeInsets.only(
                                        left: index == dismissibleIndex
                                            ? dismissible
                                            : 0,
                                        bottom: index == allMessage.length - 1
                                            ? 30
                                            : 10,
                                        top: index == 0 ? tall : 0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        if (user)
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 13),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              alignment: Alignment.center,
                                              child: RoundedImage(
                                                  url: mainController
                                                      .user.value!.profileImg,
                                                  asset: imgTestUser,
                                                  height: 30,
                                                  width: 30)),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: user
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              removeUrl(allMessage[index]
                                                      .sender
                                                      ?.username ??
                                                  ''),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                            space4,
                                            Stack(
                                              children: [
                                                if (allMessage[index].parent != null)
                                                   Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                searchShadowColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        borderRadius15)),
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 21,
                                                                right: 21,
                                                                top: 16,
                                                                bottom: 26),
                                                        margin: const EdgeInsets.only(bottom: 40),
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: Text(
                                                            allMessage
                                                                .firstWhere((element) =>
                                                                    element
                                                                        .sId ==
                                                                    allMessage![
                                                                            index]
                                                                        .parent!)
                                                                .content!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge!
                                                                .copyWith(
                                                                    letterSpacing:
                                                                        -0.02),
                                                          ),
                                                        )),
                                                   Visibility(
                                                    visible: allMessage[index].parent == null,
                                                     child: Container(
                                                      
                                                          decoration: BoxDecoration(
                                                              color: searchColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          borderRadius15)),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 16,
                                                                  horizontal: 21),
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            child: Text(
                                                              allMessage[index]
                                                                  .content!,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      letterSpacing:
                                                                          -0.02),
                                                            ),
                                                          )),
                                                   ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: searchColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  borderRadius15)),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 16,
                                                          horizontal: 21),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        child: Text(
                                                          allMessage[index]
                                                              .content!,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      -0.02),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        if (!user)
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 13),
                                              padding:
                                                  const EdgeInsets.all(short),
                                              decoration: BoxDecoration(
                                                  color: blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              alignment: Alignment.center,
                                              child: RoundedImage(
                                                  url: allMessage[index]
                                                      .sender
                                                      ?.profileImg,
                                                  asset: imgTestUser,
                                                  height: 45,
                                                  width: 45)),
                                      ],
                                    )),
                              );
                            })
                        : const SizedBox();
                  }),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: tiny),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        MainButton(
                          onPressed: () {},
                          shadow: false,
                          color: blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: tiny, vertical: tiny),
                          child: const Icon(
                            Icons.add,
                            color: white,
                          ),
                        ),
                        space13,
                        Flexible(
                          child: TextField(
                            focusNode: inputNode,
                            controller: ctrl.contentController,
                            decoration: InputDecoration(
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: black),
                                fillColor: searchColor,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 14),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(borderRadius15))),
                                hintText: typeMessage,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: inputGray)),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: black),
                          ),
                        ),
                        space13,
                        MainButton(
                          onPressed: () {
                            ctrl.send(chat.sId!, parentMessage);
                            setState(() {
                              parentMessage = null;
                            });
                            if (controller.hasClients) {
                              controller
                                  .jumpTo(controller.position.maxScrollExtent);
                            }
                          },
                          shadow: false,
                          color: Colors.transparent,
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            Icons.send,
                            color: blue,
                            size: 36,
                          ),
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
