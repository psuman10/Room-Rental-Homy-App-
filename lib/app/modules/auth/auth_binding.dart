import 'package:get/instance_manager.dart';
import 'package:homy_app/app/modules/auth/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
