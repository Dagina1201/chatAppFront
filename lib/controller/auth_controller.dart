import 'package:front/data/data.dart';
import 'package:front/global/global.dart';
import 'package:front/provider/provider.dart';
import 'package:front/routes.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  Api api = Api();

  final storage = GetStorage();
  final loading = false.obs;

  login(String email, String profileImg, String username) async {
    loading.value = true;
    final res = await api.login(User(email: email, profileImg: profileImg, username: username));
    res.fold((l) => null, (r) => {storage.write(StorageKeys.token.name, r.data)});
    Get.toNamed(Routes.main);
    loading.value = false;
  }

  logout() async {
    await storage.remove(StorageKeys.token.name);
    Get.toNamed(Routes.auth);
  }
}
