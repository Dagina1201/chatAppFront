
import 'package:flutter/material.dart';
import 'package:front/provider/provider.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dart:developer' as dev;



class AuthController extends GetxController {
  Api api = Api();

  final storage = GetStorage();
  final loading = false.obs;
  final isVisible = true.obs;
  @override
  onInit() {
    super.onInit();
 
  }
  // login
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();
  final phone = "".obs;
  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();
  // register
  final lastNameFocus = FocusNode();
  final firstNameFocus = FocusNode();
 

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  
 
  showPassword() async {
    isVisible.value = !isVisible.value;
    await Future.delayed(const Duration(milliseconds: 500));
    isVisible.value = !isVisible.value;
  }

  

  _loginEmailListener() {
    if (loginPhoneController.text.length == 8) {
      Get.focusScope?.unfocus();
    }
  }

  register() async {
    
 
      loading.value = true;

      
      loading.value = false;
   
     
  }

  login() async {
   

   
      loading.value = true;

      
   
      loading.value = false;

      
  
    
  }

  // forgetPassword(BuildContext context) async {

  
  @override
  void dispose() {
   
    super.dispose();
  }

}
