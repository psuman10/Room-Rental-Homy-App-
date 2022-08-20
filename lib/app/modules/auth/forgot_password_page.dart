import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:homy_app/app/widgets/custom_input_text.dart';

import '../../data/services/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              child: Text(
                "Please enter your registered email below to receive password reset instruction ",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              child: CustomIputText(
                title: "Your Email",
                hint: "Email",
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
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 16.0,
              ),
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
    );
  }
}
