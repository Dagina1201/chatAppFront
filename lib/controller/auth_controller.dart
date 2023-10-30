import 'package:front/global/global.dart';
import 'package:front/provider/provider.dart';
import 'package:front/routes.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  Api api = Api();

  final storage = GetStorage();
  final loading = false.obs;

  login(String value) async {
    loading.value = true;

    await storage.write(StorageKeys.token.name, value);
    Get.toNamed(Routes.main);
    loading.value = false;
  }

  logout() async {
    await storage.remove(StorageKeys.token.name);
    Get.toNamed(Routes.auth);
  }
}
