import 'package:flutter/material.dart';
import 'package:front/controller/auth_controller.dart';
import 'package:front/global/constant/constant.dart';

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
    return  Scaffold(body: SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: origin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 16),
                      child: Image.asset(
                        imageLogo,
                        width: MediaQuery.of(context).size.width > 400
                            ? 200
                            : MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                
                  ],
                )),
          ),
        ],
      ),
    ))
    ;
  
  }
}