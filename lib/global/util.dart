import 'package:flutter/material.dart';
import 'package:front/global/constant/constant.dart';
import 'package:front/global/global.dart';

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
  mainAlertDialog(String text, String label, BuildContext context,AlertType type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return 
       AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: huge),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), ),
      actions: [
        Stack(
          children: [
            Positioned(
  top: 50,
  bottom: 0,
  left: 0,
  right: 0,
  child: Container(
    
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(borderRadius15),
      boxShadow: [
        BoxShadow(offset: const Offset(0, 4), color: whiteShadow)
      ]
    ),)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: large),
              width: MediaQuery.of(context).size.width ,
              child: Column(
                
                children: [
                
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.check_circle_outline_rounded, size: 60, color: white,),
                  ),
                  space45,
                  Text(text, style: Theme.of(context).textTheme.titleSmall!.copyWith(letterSpacing: -0.02),),
                  space13,
                  Text(label, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textGray, letterSpacing: -0.02),textAlign: TextAlign.center,),
                  space58,
             
                      MainButton(
                        width: double.infinity,
                        onPressed: () {
                        Navigator.pop(context);
                      }, textColor: Colors.white, label: thanks, color: green , shadowColor:greenShadow ,),
                    
                  space13,

                ],
              ),
            ),

          ],
        )
      ],
    );
      },
    );

  }

}