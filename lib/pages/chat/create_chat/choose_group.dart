import 'package:flutter/material.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';

class ChooseGroupWidget extends StatelessWidget {
  const ChooseGroupWidget({super.key, required this.data});
final List<Chat> data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(chooseGroup, style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold, letterSpacing: -0.02),),
        space22,
        GridView.count(
  
          crossAxisCount: 3,
          
          children: data.map((e) => ChooseGroupCard(name: '${e.name}${e.number}${e.groupNumber != null ? '_' : ""}${e.groupNumber ?? ''}', uri: e.img ?? "https://www.ufe.edu.mn/icon/ufe(1).svg")).toList()
        ),
      ],
      
    );
  }
}