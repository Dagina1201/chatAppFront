import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.data, required this.index});
final Chat data;
final int index;
  @override
  Widget build(BuildContext context) {
    Color color = waterBlue, shadowColor = waterBlueShadow, textColor = black,  btnColor = orange, btnShadowColor = orangeShadow,  btnTextColor = black;
    switch(index % 3) {
case  0:
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
Text('${data.name!.toUpperCase()}${data.number}_${data.groupNumber ?? ''}', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor, letterSpacing: -0.02),),
space9,
Padding(padding: EdgeInsets.only(left: tall), child: Text('$changes: 23', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor),),),
space9,
Padding(padding: const EdgeInsets.only(left: tall), child: 

Row(
  children: <Widget>[
    Icon(Icons.person_2_outlined, color: textColor,),
    
    Text('$students: 100', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor)),
  ],
)
 ),

            ],
          ),
MainButton(
  padding: const EdgeInsets.symmetric(vertical: regular, horizontal:large ),
  onPressed: () {}, label: goChat, color: btnColor, shadowColor: btnShadowColor, textColor: btnTextColor,)
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
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImage(
            imageUrl: uri,
            progressIndicatorBuilder: (context, url, progress) => CircularProgressIndicator(),
          ),
        ),
        space13,
        Text(name, style: Theme.of(context).textTheme.labelLarge!.copyWith(letterSpacing: -0.02),)
      ],
    );
  }
}