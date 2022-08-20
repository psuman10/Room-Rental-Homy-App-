import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/data/models/user.dart';
import 'package:homy_app/app/data/services/auth_service.dart';
import 'package:homy_app/app/modules/auth/auth_binding.dart';
import 'package:homy_app/app/modules/auth/login_page.dart';
import 'package:homy_app/app/modules/landing/landing_page.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final eyeVisibleLogin = false.obs;
  final eyeVisibleRegister = false.obs;

  //toggle eye visibility in login page
  void toggleEye(bool value) {
    eyeVisibleLogin.value = value;
  }

  //toggle eye visibility in register page
  void toggleEyeRegister(bool value) {
    eyeVisibleRegister.value = value;
  }

  void loginWithEmailPassword(String email, String password) async {
    EasyLoading.show(status: "Please wait..");
    final result =
        await _authService.loginWithEmail(email: email, password: password);
    result.fold((fail) {
      EasyLoading.showError(fail.message);
    }, (data) {
      EasyLoading.showSuccess("Login success");
      Get.off(() => const LandingPage(), binding: AuthBinding());
    });
  }

  void registerWithEmail(UserModel user) async {
    EasyLoading.show(status: "Please wait ...");

    final result = await _authService.register(user: user);

    result.fold((fail) {
      EasyLoading.showError(fail.message);
    }, (data) {
      EasyLoading.showSuccess("Registraton Sucess");
      Get.off(() => const LandingPage(), binding: AuthBinding());
    });
  }

  void loginWithGoogle() async {
    EasyLoading.show(status: "Please wait ...");

    final result = await _authService.signInWithGoogle();

    result.fold(
      (fail) => EasyLoading.showError(fail.message),
      (r) {
        EasyLoading.showSuccess("Login success");
        Get.off(() => const LandingPage(), binding: AuthBinding());
      },
    );
  }

  void loginWithFacebook() async {
    EasyLoading.show(status: "Please wait ...");

    final result = await _authService.loginWithFacebook();

    result.fold(
      (fail) => EasyLoading.showError(fail.message),
      (r) {
        EasyLoading.showSuccess("Login success");
        Get.off(() => const LandingPage(), binding: AuthBinding());
      },
    );
  }

  void logout() async {
    EasyLoading.show(status: "Logging out..");

    final result = await _authService.logout();
    result.fold((fail) {
      EasyLoading.showError("Fail to logout");
    }, (isLogout) {
      EasyLoading.dismiss();
      Get.off(() => const LoginPage());
    });
  }
}
