import 'package:flutter/material.dart';
import 'package:iamtalking/core/widgets/custom_text_field.dart';
import 'package:iamtalking/generated/l10n.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: S.of(context).email,
      textController: emailController,
      obsecureText: false,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == '') {
          return S.of(context).please_enter_your_email;
        } else if (!value!.contains('@')) {
          return S.of(context).please_enter_a_valid_email;
        }
        return null;
      },
    );
  }
}
