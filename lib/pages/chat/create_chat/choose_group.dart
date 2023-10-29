import 'package:flutter/material.dart';
import 'package:front/controller/chat_container.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:get/get.dart';

class ChooseGroupWidget extends StatelessWidget {
  const ChooseGroupWidget({super.key, required this.data});
final List<Chat> data;
  @override
  Widget build(BuildContext context) {
final controller = Get.put(ChatController());
    return 
          
        SizedBox(
          height: MediaQuery.of(context).size.height -  MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - most - most - most - medium - medium,
          width: double.infinity,
          child: GridView.count(
           
            crossAxisCount: 3,
            mainAxisSpacing: medium,
            crossAxisSpacing: medium,
            shrinkWrap: true,
            childAspectRatio: 0.6,
            children: data.map((e) => GestureDetector(
              
              onTap: () {
                controller.createStep.value = 1;
                controller.choseGroup.value = '${e.name}${e.number}${e.groupNumber != null ? '_' : ""}${e.groupNumber ?? ''}';
              },
              child: ChooseGroupCard(name: '${e.name}${e.number}${e.groupNumber != null ? '_' : ""}${e.groupNumber ?? ''}', uri: e.img ?? "https://www.ufe.edu.mn/image/%D0%BB%D0%BE%D0%B3%D0%BE%20%D0%B1%D0%BE%D1%81%D0%BE%D0%BE.png"))).toList()
              
            ),
        );
  }
}