import 'package:flutter/material.dart';

import 'package:iamtalking/core/widgets/custom_text_field.dart';
import 'package:iamtalking/generated/l10n.dart';

// ignore: must_be_immutable
class NameField extends StatelessWidget {
  NameField({super.key, required this.nameController});
  TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: S.of(context).name,
      textController: nameController,
      obsecureText: false,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == '') {
          return S.of(context).please_enter_your_name;
        }
        return null;
      },
    );
  }
}
