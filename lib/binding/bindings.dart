import 'package:front/controller/controllers.dart';
import 'package:get/get.dart';


class AppBinding implements Bindings {
  @override
  void dependencies() {}
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(), permanent: true);
  }
}
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    
  }
}
class OrderBinding extends Bindings {
  @override
  void dependencies() {
    
  }
}