import 'package:flutter/material.dart';
import 'package:front/controller/chat_container.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:get/get.dart';

class ChooseStudentWidget extends StatelessWidget {
  const ChooseStudentWidget({super.key, required this.data});
final List<User> data;
  @override
  Widget build(BuildContext context) {
   final controller = Get.put(ChatController());
    return 
       
        SizedBox(
          height: MediaQuery.of(context).size.height - most - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - most - most - medium - medium - small - medium,
          width: double.infinity,
          child: GridView.count(
  shrinkWrap: true,
          crossAxisCount: 3,
            mainAxisSpacing: medium,
            crossAxisSpacing: medium,
          
            childAspectRatio: 0.6,
          children: data.map((e) {
            final i = data.indexOf(e);
            return ChooseStudentCard(data: e, index: i);
          }).toList()
    ),
        );
  }
}