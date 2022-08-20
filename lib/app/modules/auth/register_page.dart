import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/data/models/user.dart';
import 'package:homy_app/app/modules/auth/auth_controller.dart';

import '../../core/values/colors.dart';
import '../../widgets/custom_input_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
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
          image: AssetImage("assets/images/room6.jpg"),
          fit: BoxFit.cover,
        )),
        child: SafeArea(child: GetBuilder<AuthController>(builder: (_authCtrl) {
          return ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Register",
                        style: TextStyle(
                            color: Color.fromARGB(255, 248, 2, 2),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 120.0, right: 120.0, bottom: 4.0),
                      child: Divider(
                        thickness: 4,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
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
                                      color: Color.fromARGB(255, 238, 4, 4),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 5, 49, 246),
                                          width: 2.0)),
                                  fillColor:
                                      const Color.fromARGB(255, 240, 1, 1),
                                  labelText: 'Username',
                                  hintText: 'Enter Your Username',
                                ),
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Name is required";
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
                                    fontSize: 22),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 0, 6, 10),
                                        width: 2.0),
                                  ),
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 246, 1, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 5, 49, 246),
                                          width: 2.0)),
                                  fillColor:
                                      const Color.fromARGB(255, 240, 1, 1),
                                  labelText: 'Email ID',
                                  hintText: 'Enter your Email ID',
                                ),
                                controller: _emailController,
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
                                    fontSize: 22),
                                    obscureText:true,
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
                                          color:
                                              Color.fromARGB(255, 5, 49, 246),
                                          width: 2.0)),
                                  fillColor:
                                      const Color.fromARGB(255, 240, 1, 1),
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
                              const SizedBox(height: 24.0),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final UserModel _user = UserModel(
                                          email: _emailController.text,
                                          fullName: _nameController.text,
                                          password: _passwordController.text,
                                        );
                                        _authCtrl.registerWithEmail(_user);
                                      }
                                    },
                                    child: const Text("Register")),
                              )
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("I have an account?",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 9, 9, 9),
                                    fontSize: 12,
                                    height: 0,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: primaryBlue,
                                  fontSize: 12,
                                  height: 0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        })),
      ),
    );
  }
}
