import 'package:get/instance_manager.dart';
import 'package:homy_app/app/modules/landing/landing_controller.dart';

class LandingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandingController());
  }
}
