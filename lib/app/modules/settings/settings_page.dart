import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/core/values/colors.dart';
import 'package:homy_app/app/data/services/auth_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings", style: Theme.of(context).textTheme.headline5),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Reset Password",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          } else if (!value.isEmail) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            const InputDecoration(hintText: "Enter Your Email"),
                      ),
                    ),
                    Text(
                      "Will send password reset link on your mail",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: textColor,
                          ),
                    ),
                    const SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            EasyLoading.show(status: "Loading...");
                            final isSendResponse = await AuthService()
                                .sendPasswordResetEmail(_emailController.text);
                            EasyLoading.dismiss();

                            isSendResponse.fold((fail) {
                              EasyLoading.showError(fail.message);
                            }, (success) {
                              _emailController.clear();
                              EasyLoading.showSuccess(
                                  "Please check your email to reset password");
                            });
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
