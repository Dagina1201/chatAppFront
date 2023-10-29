import 'package:flutter/material.dart';
import 'package:front/controller/controllers.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:get/get.dart';

class StudentSearchDelegate extends SearchDelegate {
  List<User> searchList = users;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final controller = Get.put(ChatController());

    List<User> matchQuery = [];
    for (var e in searchList) {
      if (e.nickname!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(e);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          User result = matchQuery[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(result.nickname ?? ''),
                Obx(() => MainButton(
                      textColor: white,
                      onPressed: () {
                        if (!controller.selectedStudents
                            .contains(result.sId!)) {
                          controller.selectedStudents.add(result.sId!);
                        }
                        // else {
                        //   controller.selectedStudents.remove(result.sId!);
                        // }
                        // print(
                        //     'adsff ${controller.selectedStudents.contains(matchQuery[index].sId!)}');
                      },
                      label: controller.selectedStudents
                              .contains(matchQuery[index].sId!)
                          ? added
                          : add,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    ))
              ],
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final controller = Get.put(ChatController());
    List<User> matchQuery = [];
    for (var e in searchList) {
      if (e.nickname!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(e);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          User result = matchQuery[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(result.nickname ?? ''),
                Obx(() => MainButton(
                      textColor: white,
                      onPressed: () {
                        if (!controller.selectedStudents
                            .contains(result.sId!)) {
                          controller.selectedStudents.add(result.sId!);
                        }
                      },
                      label: controller.selectedStudents
                              .contains(matchQuery[index].sId!)
                          ? added
                          : add,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    ))
              ],
            ),
          );
        });
  }
}
