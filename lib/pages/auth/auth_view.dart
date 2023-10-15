import 'package:flutter/material.dart';
import 'package:front/controller/auth_controller.dart';

import 'package:front/global/global.dart';

import 'package:front/routes.dart';
import 'package:get/get.dart';


class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
   final loginKey = GlobalKey<FormState>();
  final  controller = Get.put(AuthController());
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: CustomAppBar(onTap: () => {}, child: space36),
      body: SingleChildScrollView(
      child: 
           Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height ,
               
                padding:  EdgeInsets.only(left: regular, right: regular, top: MediaQuery.of(context).padding.top + 65, bottom: medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(loginProLogo),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(lorem, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: subTextColor), ),
                        ),
                        space58,

                        MainButton(
                          borderRadius: borderRadius50,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(imageLogo, height: 48,),
                            space13,
                            Text(signGoogle, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white),)
                          ],
                        ), onPressed: () {
                      Get.toNamed(Routes.main);
                    },),
                      space58,
                      Image.asset(imageLogo, height: 24,)
                      ],
                    )
                  ],
                )
          ),
        
      
    ))
    ;
  
  }
}