import 'package:flutter/material.dart';
import 'package:front/data/model/user.dart';
import 'package:front/global/global.dart';
import 'package:front/provider/provider.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController
    with StateMixin<User>, WidgetsBindingObserver {
  final Api api = Api();
  final storage = GetStorage();
  final loading = false.obs;
  final user = Rxn<User>();

  Future<void> setupApp() async {
    loading.value = true;
    try {
      loading.value = false;
      getUser();
    } catch (e) {
      loading.value = false;

      update();
    }
  }

  void getUser() async {
    final token = storage.read(StorageKeys.token.name);
    if (token != null) {
      final res = await api.getUser();
      res.fold((l) => null, (r) => user.value = r);
    }
  }

  logout() async {
    await storage.remove(StorageKeys.token.name);
    Get.toNamed(Routes.auth);
  }

  @override
  void onInit() async {
    await setupApp();
    super.onInit();
  }
}
