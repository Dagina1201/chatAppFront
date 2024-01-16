import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(
      {super.key,
      required this.data,
      required this.index,
      required this.onPressed});
  final Chat data;
  final int index;
  final Function(String v) onPressed;
  @override
  Widget build(BuildContext context) {
    Color color = waterBlue,
        shadowColor = waterBlueShadow,
        textColor = black,
        btnColor = orange,
        btnShadowColor = orangeShadow,
        btnTextColor = black;
    switch (index % 3) {
      case 0:
        color = blue;
        textColor = white;
        btnTextColor = white;
        btnColor = orange;
        btnShadowColor = orangeShadow;
        shadowColor = blueShadow;
        break;
      case 1:
        color = grayBlue;
        shadowColor = grayBlueShadow;
        textColor = black;
        btnTextColor = black;
        btnColor = whiteness;
        btnShadowColor = whitenessShadow;
        break;
    }

    return MainContainer(
      animate: true,
      color: color,
      shadowColor: shadowColor,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shadow: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${data.name!.toUpperCase()}${data.number}_${data.groupNumber ?? ''}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: textColor, letterSpacing: -0.02),
              ),
              // space2,
              Padding(
                padding: EdgeInsets.only(left: tall),
                child: Text(
                  '$changes: 23',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: textColor),
                ),
              ),
              // space2,
              Padding(
                  padding: const EdgeInsets.only(left: tall),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person_2_outlined,
                        color: textColor,
                      ),
                      Text('$students: ${data.users?.length ?? 0}',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: textColor)),
                    ],
                  )),
            ],
          ),
          MainButton(
            padding: const EdgeInsets.symmetric(
                vertical: regular, horizontal: large),
            onPressed: () => {
              Get.toNamed(Routes.message, arguments: [data.sId!]),
              onPressed(data.sId!)
            },
            label: goChat,
            color: btnColor,
            shadowColor: btnShadowColor,
            textColor: btnTextColor,
          )
        ],
      ),
    );
  }
}

class ChooseGroupCard extends StatelessWidget {
  const ChooseGroupCard({super.key, required this.name, required this.uri});
  final String name;
  final String uri;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          radius: (MediaQuery.of(context).size.width - (2 * medium)) / 3 / 2,
          backgroundColor: Colors.transparent,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius:
                (MediaQuery.of(context).size.width - (2 * medium)) / 3 / 2 - 20,
            backgroundImage: NetworkImage(uri),
          ),
        ),
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(letterSpacing: -0.02),
        )
      ],
    );
  }
}

class ChooseStudentCard extends StatelessWidget {
  const ChooseStudentCard(
      {super.key,
      required this.data,
      this.active = false,
      required this.index});
  final User data;
  final int index;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: waterBlue, borderRadius: BorderRadius.circular(100)),
                child: data.profileImg != null && data.profileImg != ""
                    ? CachedNetworkImage(imageUrl: data.profileImg!)
                    : Image.asset(
                        imgTestUser,
                      ),
              ),
            ),
            if (active)
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: white, width: 5),
                        color: green,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Icons.check,
                      color: white,
                      size: 35,
                    ),
                  ))
          ],
        ),
        Text(
          data.username ?? "",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(letterSpacing: -0.02),
        )
      ],
    );
  }
}
