
import 'package:front/binding/bindings.dart';
import 'package:front/pages/pages.dart';
import 'package:get/get.dart';


class Routes {
// routes
  static String splash = '/';

  // main

  static String main = '/main';
// prime
  static String prime = '/prime';
  static String primeLawyer = '$prime/lawyer';
  // auth
  static String auth = '/login';
  static String register = '/register';

// pages
  static final pages = [
    // splash
    GetPage(
        name: splash,
        page: () => const SplashView(),
        binding: SplashBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),

    // home
    GetPage(
        name: main,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
    //  auth
    GetPage(
        name: auth,
        page: () => const AuthView(),
        binding: AuthBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300)),
  ];
}
