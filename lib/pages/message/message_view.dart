import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key, required this.id});
  final String id;
  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final GlobalKey<ScaffoldState> messageKey = GlobalKey<ScaffoldState>();
  List<Message> data = [];
  Chat chat = Chat();
  ScrollController controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    // controller.jumpTo(controller.position.maxScrollExtent);
    setState(() {
      chat = groups.firstWhere((element) => element.sId == widget.id);
      data = messages.where((element) => element.chat == '1').toList();
      // data = messages.where((element) => element.chat == widget.id).toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      controller.jumpTo(controller.position.maxScrollExtent);
    });
    return Scaffold(
      key: messageKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(150 + MediaQuery.of(context).padding.top),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
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
                      icon: Icon(
                        Icons.arrow_back,
                        color: white,
                      )),
                  MainButton(
                    padding: EdgeInsets.all(8),
                    shadow: false,
                    onPressed: () {},
                    child: Icon(
                      Icons.message_rounded,
                      size: 20,
                      color: white,
                    ),
                  )
                ],
              ),
              space13,
              Text(
                '${chat.name}${chat.number}${chat.groupNumber != null ? '_' : ""}${chat.groupNumber ?? ''}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: white, letterSpacing: -0.02),
              ),
              space9,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AvatarListWidget(data: users),
                  MainButton(
                    shadow: false,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                          child: Icon(
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
        padding: EdgeInsets.only(right: medium, bottom: regular, left: medium),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 4),
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  controller: controller,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: (Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (index % 2 == 0)
                            Container(
                              margin: EdgeInsets.only(right: 13),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(100)),
                              alignment: Alignment.center,
                              child: Image.asset(
                                imgTestUser,
                                width: 45,
                              ),
                            ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: index % 2 == 0
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(data[index].sender!.nickname!),
                              space4,
                              Container(
                                width: MediaQuery.of(context).size.width - 120,
                                decoration: BoxDecoration(
                                    color: searchColor,
                                    borderRadius:
                                        BorderRadius.circular(borderRadius15)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 21),
                                child: Text(
                                  data[index].content!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(letterSpacing: -0.02),
                                ),
                              )
                            ],
                          ),
                          if (index % 2 != 0)
                            Container(
                              margin: EdgeInsets.only(left: 13),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(100)),
                              alignment: Alignment.center,
                              child: Image.asset(
                                imgTestUser,
                                width: 45,
                              ),
                            ),
                        ],
                      )),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
