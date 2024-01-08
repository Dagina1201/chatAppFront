import 'package:dio/dio.dart';
import 'package:front/global/global.dart';
import 'package:front/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dart:developer' as dev;

class SplashController extends GetxController {
  late Worker worker;
  final storage = GetStorage();
  final token = Rxn<String?>();
  // final mainController = Get.put(MainController());
  @override
  void onInit() async {
    try {
      final isCurrent = await _isCurrentVersion();
      if (isCurrent == null) {
      } else {
        if (isCurrent) {
          _checkAuthStatus();
        } else {
          // _showUpdateDialog();
        }
      }
    } on Exception catch (e) {
      dev.log(e.toString());
    }
    super.onInit();
  }

  Future<bool?> _isCurrentVersion() async {
    try {
      return true;
    } on DioException {
      return null;
    } catch (e) {
      return null;
    }
  }

  /// CHECKING UPDATE VERSION

  _checkAuthStatus() async {
    print('tkn: ');
    worker = ever<String?>(
      token,
      (tkn) async {
        print(tkn);
        print('tkn: ${tkn}');
        if (tkn != null) {
          // await storage.write(StorageKeys.currentPage.name, 0);
          Get.toNamed(Routes.main);
        } else {
          Get.toNamed(Routes.main);
          // Get.toNamed(Routes.auth);
        }
      },
    );
    token.value = storage.read(StorageKeys.token.name);
  }

  @override
  void dispose() {
    worker.dispose();
    super.dispose();
  }
}
