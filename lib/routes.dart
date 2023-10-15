
import 'package:front/binding/bindings.dart';
import 'package:front/pages/pages.dart';
import 'package:get/get.dart';


class Routes {
// routes
  static String splash = '/';

  // main

  static String main = '/main';
  // home
  static String home = '/home';

  // chat

  static String chat = '/chat';
  static String team = '$chat/team';

  // auth
  static String auth = '/login';


// pages
  static final pages = [
    // splash
    GetPage(
        name: splash,
        page: () => const SplashView(),
        binding: SplashBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 100)),

     
    // home
    GetPage(
        name: home,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 100)),
    //  auth
    GetPage(
        name: auth,
        page: () => const AuthView(),
        binding: AuthBinding(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 100)),
    GetPage(
        name: chat,
        page: () => const ChatView(),

        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 100)),
  ];
}
