import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front/controller/controllers.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/provider/api.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

class StudentSearchDelegate extends SearchDelegate<FutureOr<Widget?>> {
  Api api = Api();
  Future search(String query) async {
    try {
      List<User> users = [];
      final res =
          await api.searchUsers(UserTypes.USER, query == "" ? " " : query);
      res.fold((l) => null, (r) => users = r);
      return users;
    } catch (e) {
      dev.log(e.toString());
    }
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

  Widget result(List<User> data) {
    final controller = Get.put(ChatController());

    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          User result = data[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(result.email ?? ""),
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
                      label:
                          controller.selectedStudents.contains(data[index].sId!)
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
    return FutureBuilder(
        future: search(query),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return result(snapshot.data as List<User>);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: search(query),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return result(snapshot.data as List<User>);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
