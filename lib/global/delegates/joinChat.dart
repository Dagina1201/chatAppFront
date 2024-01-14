import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front/controller/controllers.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/provider/api.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';

class JoinChatSearchDelegate extends SearchDelegate<FutureOr<Widget?>> {
  Api api = Api();
  Future search(String query) async {
    final res = await api.search(ChatTypes.ALL, query == ""  ? " " : query);
    List<Chat> l = [];
    res.fold((l) => null, (r) => l = r);
    return l;
  }

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
    return FutureBuilder(
        future: search(query),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return result(snapshot.data as List<Chat>);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }

  Widget result(List<Chat> data) {
    final controller = Get.put(ChatController());

    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          Chat result = data[index];
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: search(query),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return result(snapshot.data as List<Chat>);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
