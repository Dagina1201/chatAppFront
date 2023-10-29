import 'package:flutter/material.dart';
import 'package:front/controller/controllers.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';

class JoinChatSearchDelegate extends SearchDelegate {
  List<Chat> searchList = groups;

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
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final controller = Get.put(ChatController());

    List<Chat> matchQuery = [];
    for (var e in searchList) {
      if (e.name!.toLowerCase().contains(query.toLowerCase()) ||
          e.groupNumber.toString().contains(query) ||
          e.number.toString().contains(query)) {
        matchQuery.add(e);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          Chat result = matchQuery[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    '${result.name}${result.number}${result.groupNumber != null ? '_' : ""}${result.groupNumber ?? ''}'),
                MainButton(
                  textColor: white,
                  onPressed: () {
                    controller.choseGroup.value =
                        '${result.name}${result.number}${result.groupNumber != null ? '_' : ""}${result.groupNumber ?? ''}';
                    controller.createStep.value = 1;
                    Navigator.pop(context);
                    Get.toNamed(Routes.message, arguments: [result.sId!]);
                  },
                  label: goChat,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                )
              ],
            ),
          );
        });
  }
}
