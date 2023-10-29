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

  static String chooseGroup = '$chat/create/group';
  static String chooseStudent = '$chat/create/student';

  // messages
  static String message = '/message';

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

    // main
    GetPage(
        name: main,
        page: () => const MainView(),
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
    // chat
    GetPage(
        name: chat,
        page: () => const ChatView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 100)),
    GetPage(
        name: chooseGroup,
        page: () => const ChooseGroupWidget(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 100)),
    GetPage(
        name: chooseStudent,
        page: () => const ChooseStudentView(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 100)),

    // messages
    GetPage(
        name: message,
        page: () {
          String id = Get.arguments[0];
          return MessageView(
            id: id,
          );
        },
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 100)),
  ];
}
