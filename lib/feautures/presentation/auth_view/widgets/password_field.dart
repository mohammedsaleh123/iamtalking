import 'package:flutter/material.dart';
import 'package:iamtalking/core/widgets/custom_text_field.dart';
import 'package:iamtalking/generated/l10n.dart';

// ignore: must_be_immutable
class PasswordField extends StatelessWidget {
  PasswordField({
    super.key,
    required this.passwordController,
    required this.obsecureText,
  });
  bool obsecureText;

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: S.of(context).password,
      textController: passwordController,
      obsecureText: obsecureText,
      validator: (value) {
        if (value == '') {
          return S.of(context).please_enter_your_password;
        }
        if (value!.length < 6) {
          return S.of(context).password_must_be_at_least_6_characters;
        }
        return null;
      },
    );
  }
}
