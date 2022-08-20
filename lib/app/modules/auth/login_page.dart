import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/core/values/colors.dart';
import 'package:homy_app/app/modules/auth/auth_binding.dart';
import 'package:homy_app/app/modules/auth/auth_controller.dart';
import 'package:homy_app/app/modules/auth/forgot_password_page.dart';
import 'package:homy_app/app/modules/auth/register_page.dart';

import '../../widgets/custom_input_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authCtrl = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
        centerTitle: true,
      ),
      body: Container(
        height: size.height * 1,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/room4.jpg"),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: GetBuilder<AuthController>(builder: (_authCtrl) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 60.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("LOGIN",
                          style: TextStyle(
                              color: Color.fromARGB(255, 248, 2, 2),
                              fontSize: 30,
                              height: 0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 120.0, right: 120.0, bottom: 4.0),
                        child: Divider(
                          thickness: 4,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            style: const TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.transparent,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 6, 10),
                                    width: 2.0),
                              ),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 5, 49, 246),
                                      width: 2.0)),
                              fillColor: const Color.fromARGB(255, 240, 1, 1),
                              labelText: 'Email ID',
                              hintText: 'Enter your Email ID',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email is required";
                              } else if (!value.isEmail) {
                                return "Invalid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24.0),
                          TextFormField(
                            style: const TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.transparent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                              ),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 5, 49, 246),
                                      width: 2.0)),
                              fillColor: const Color.fromARGB(255, 240, 1, 1),
                              labelText: 'Password',
                              hintText: 'Enter your Password',
                            ),
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              } else if (value.length < 6) {
                                return "Password length must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(const ForgotPasswordPage());
                                },
                                child: Text("Forgot Password?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(color: primaryBlue))),
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      authCtrl.loginWithEmailPassword(
                                          _emailController.text,
                                          _passwordController.text);
                                    }
                                  },
                                  child: const Text("Login")))
                        ],
                      )),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20.0),
                  child: const Text("Or login with",
                      style: TextStyle(
                          color: Color.fromARGB(255, 251, 251, 253),
                          fontSize: 15,
                          height: 0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            authCtrl.loginWithGoogle();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 20.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                                color: primaryLight.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child:
                                      Image.asset("assets/images/google.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    "Google",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            authCtrl.loginWithFacebook();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                                color: primaryLight.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child:
                                      Image.asset("assets/images/facebook.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    "Facebook",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const RegisterPage(), binding: AuthBinding());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Don't have an account?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 9, 9, 9),
                              fontSize: 12,
                              height: 0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: primaryBlue,
                            fontSize: 12,
                            height: 0,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
