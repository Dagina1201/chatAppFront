import 'package:dio/dio.dart';
import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/provider/api.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dart:developer' as dev;

class MessageController extends GetxController {

  final chats = <Chat>[].obs;
  final api = Api();
  @override
  void onInit() async {
    try {

    } on Exception catch (e) {
      dev.log(e.toString());
    }
    super.onInit();
  }

 
  @override
  void dispose() {
    super.dispose();
  }
}
