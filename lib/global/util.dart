import 'package:flutter/material.dart';
import 'package:front/global/constant/constant.dart';

import 'package:get_storage/get_storage.dart';


  final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
class Util {
  final storage = GetStorage();
  //  final AuthController controller = Get.find();
  // token
  void saveToken(String token) {
    storage.write(StorageKeys.token.name, token);
  }
  void logout() {
    storage.remove(StorageKeys.token.name);
  }



mainSnackbar(
   
    String text,
    SnackbarType type,
  ) {
    Color color = success;
    IconData icon = Icons.check;
    // bool keyboard = WidgetsBinding.instance.window.viewInsets.bottom > 0;
    switch (type) {
      case SnackbarType.error:
        color = error;
        icon = Icons.error;
        break;
      case SnackbarType.warning:
        color = warning;
        icon = Icons.info;
        break;
      default:
        color = success;
        icon = Icons.check;
    }
    final SnackBar snackBar = SnackBar(
      duration: const Duration(milliseconds: 1500),
      padding:  const EdgeInsets.symmetric(horizontal: regular, vertical: small),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: Colors.white,),
        space16,
        Flexible(child: Text(text, maxLines: 3,), )
      ],
    ));

   snackbarKey.currentState?.showSnackBar(snackBar);
  }
  

}