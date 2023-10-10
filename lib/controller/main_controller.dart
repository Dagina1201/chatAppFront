
import 'package:flutter/material.dart';
import 'package:front/data/model/user.dart';
import 'package:front/global/global.dart';
import 'package:front/provider/provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController
    with StateMixin<User>, WidgetsBindingObserver {
  final Api api = Api();
  final storage = GetStorage();
  final loading = false.obs;
  final currentIndex = 0.obs;
  Future<void> setupApp() async {
    loading.value = true;
    try {
  
      
    loading.value = false;
      
    } catch (e) {
    loading.value = false;

      update();
    }
  }

 
  logout() async {
await storage.remove(StorageKeys.token.name);
setupApp();
    
    
  }


  @override
  void onInit() async {
    await setupApp();
    super.onInit();
  }


}
