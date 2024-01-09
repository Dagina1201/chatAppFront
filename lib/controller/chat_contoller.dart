import 'package:dio/dio.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/provider/api.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dart:developer' as dev;

class ChatController extends GetxController {
  final createStep = 0.obs;
  final choseGroup = "".obs;
  final selectedStudents = <String>[].obs;
  final searchUsers = <User>[].obs;
  final chats = <Chat>[].obs;
  final api = Api();
  @override
  void onInit() async {
    try {
      chats.value = groups;
      searchUsers.value = users;
    } on Exception catch (e) {
      dev.log(e.toString());
    }
    super.onInit();
  }

  void connect(String chat) {
    api.socket.emit('join', "659ceee0335be42e8e4e25cd");
    api.socket.emit('message', {
      "chat": "659ceee0335be42e8e4e25cd",
      "sender": "652227f0a08d7adcbfbf28ea",
      // "content": "tes123123 adsf adsf",
      "messageType": "TEXT"
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
