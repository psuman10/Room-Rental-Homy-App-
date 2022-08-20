import 'package:flutter/material.dart';

class CustomIputText extends StatelessWidget {
  const CustomIputText({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.validator, this.suffixIcon,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: inputType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
          ),
        )
      ],
    );
  }
}
