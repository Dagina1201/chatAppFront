import 'package:flutter/material.dart';
import 'package:front/controller/controllers.dart';
import 'package:front/global/global.dart';
import 'package:front/pages/main/main.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool isTeam = false;

  @override
  Widget build(BuildContext context) {
    return MainView(
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
                                      decoration: !isTeam
                                          ? TextDecoration.none
                                          : TextDecoration.underline)),
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
              )),
              space20,
              MainContainer(
                color: searchColor,
                shadow: true,
                shadowColor: searchShadowColor,
                padding: EdgeInsets.symmetric(vertical: regular),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search,),
                  space4,
                  TextFormField(decoration:InputDecoration( hintText:  lessonCodeGroupNumber,hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: placeholderColor, letterSpacing: -0.02)))
                ],
              )),
          space32,
          Text(
            chats,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.bold, letterSpacing: -0.02),
          ),
          space9,
          ...groups.map((e) {
            int index = groups.indexOf(e);
            return ChatCard(
              data: e,
              index: index,
            );
          })
        ],
      ),
    ));
  }
}
