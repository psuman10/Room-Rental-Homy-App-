import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/modules/auth/auth_binding.dart';
import 'package:homy_app/app/modules/auth/login_page.dart';
import 'package:homy_app/app/modules/landing/landing_binding.dart';
import 'package:homy_app/app/modules/landing/landing_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "Homy - Rental Solution",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }

  void _checkAuth() {
    Future.delayed(const Duration(seconds: 1), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.off(const LoginPage(), binding: AuthBinding());
        } else {
          Get.off(const LandingPage(), binding: LandingBinding());
        }
      });
    });
  }
}
