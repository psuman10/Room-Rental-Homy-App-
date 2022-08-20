import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/core/utils/app_theme.dart';
import 'package:homy_app/app/modules/auth/auth_binding.dart';
import 'package:homy_app/app/modules/auth/forgot_password_page.dart';
import 'package:homy_app/app/modules/auth/login_page.dart';
import 'package:homy_app/app/modules/auth/register_page.dart';
import 'package:homy_app/app/modules/home/bottomnav.dart';
import 'package:homy_app/app/modules/landing/landing_binding.dart';
import 'package:homy_app/app/modules/landing/landing_page.dart';

import 'app/modules/splash/splash_page.dart';
import 'firebase_options.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Homy - One Rental Solution",
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      builder: EasyLoading.init(),
      initialBinding: AuthBinding(),
      home: const SplashPage(),
      getPages: [
        GetPage(
          name: "/login",
          page: () => const LoginPage(),
        ),
        GetPage(
          name: "/register",
          page: () => const RegisterPage(),
        ),
        GetPage(
          name: "/splash",
          page: () => const SplashPage(),
        ),
        GetPage(
          name: "/forgotPassword",
          page: () => const ForgotPasswordPage(),
        ),
        GetPage(
          name: "/landing",
          page: () => const LandingPage(),
          binding: LandingBinding(),
        ),
        GetPage(
          name: "/nav",
          page: () => const NavBottompract(),
        ),
      ],
    );
  }
}
