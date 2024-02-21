import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:front/controller/controllers.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/provider/api.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dart:developer' as dev;

class SurveyController extends GetxController {
  final createStep = 0.obs;
  final choseGroup = "".obs;
  final choseGroupId = "".obs;
  final selectedStudents = <String>[].obs;
  final searchedUsers = <User>[].obs;
  final searchedChat = <Chat>[].obs;
  final chats = <Chat>[].obs;
  final api = Api();
  final contentController = TextEditingController();
  final joinedChat = Rxn(Chat());
  final currentChatUsers = <User>[].obs;
  final mainController = Get.put(MainController());

  @override
  void onInit() async {
    try {
      search(ChatTypes.GROUP, " ");
      searchUsers(UserTypes.USER, " ");
    } on Exception catch (e) {
      dev.log(e.toString());
    }
    super.onInit();
  }

  void search(ChatTypes type, String value) async {
    try {
      final res = await api.search(type, value);

      res.fold((l) => print(l), (r) => searchedChat.value = r);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<Chat> getChatById(String id) async {
    try {
      Chat chat = Chat();
      final res = await api.getChatById(id);
      res.fold((l) => print(l), (r) => chat = r);
      return chat;
    } catch (e) {
      return Chat();
    }
  }

  void searchUsers(UserTypes type, String value) async {
    try {
      final res = await api.searchUsers(type, value);

      res.fold((l) => print(l), (r) => searchedUsers.value = r);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  void getChats(ChatTypes type) async {
    try {
      final res = await api.getChats(type);
      res.fold((l) => print('asdf'), (r) => chats.value = r);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<bool> create(
    ChatTypes type,
  ) async {
    try {
      final res =
          await api.createChat(type, choseGroupId.value, selectedStudents);
      bool v = false;
      res.fold((l) => print('asdf'), (r) => v = r);
      return v;
    } catch (e) {
      dev.log(e.toString());
      return false;
    }
  }

  void getChat(
    String chat,
  ) async {
    try {
      final res = await api.getChatUsers(chat);

      res.fold((l) => print(l), (r) => currentChatUsers.value = r);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<void> join(String chat) async {
    try {
      final res = await api.joinChat(chat);
      res.fold((l) => dev.log(l), (r) => dev.log(Messages.success));
    } catch(e) {
      dev.log(e.toString());
    }
  }

  void connect(String chat) {
    api.socket.emit('join', chat);
    api.socket.emit('message', {
      "chat": chat,
      "sender": mainController.user.value!.sId!,
      "messageType": "TEXT"
    });
  }

  void send(
    String chat,
    String? parent
  ) {
    
    api.socket.emit('message', {
      "chat": chat,
      "sender": mainController.user.value!.sId!,
      "content": contentController.text,
      "parent": parent,
      "messageType": "TEXT"
    });
    contentController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
  }
}
