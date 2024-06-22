import 'package:flutter/material.dart';
import 'package:iamtalking/core/widgets/custom_text_field.dart';
import 'package:iamtalking/generated/l10n.dart';

// ignore: must_be_immutable
class ConfirmPasswordField extends StatelessWidget {
  ConfirmPasswordField(
      {super.key,
      required this.confirmPasswordController,
      required this.obsecureText});
  TextEditingController confirmPasswordController;
  bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: S.of(context).confirm_password,
      textController: confirmPasswordController,
      obsecureText: obsecureText,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == '') {
          return S.of(context).please_enter_your_confirm_password;
        }
        if (value != confirmPasswordController.text) {
          return S.of(context).password_does_not_match;
        }
        return null;
      },
    );
  }
}
