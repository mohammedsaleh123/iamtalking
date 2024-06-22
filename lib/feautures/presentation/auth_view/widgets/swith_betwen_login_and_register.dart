import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/utils/app_colors.dart';

// ignore: must_be_immutable
class SwitchBetwenLogInAndRegister extends StatelessWidget {
  SwitchBetwenLogInAndRegister(
      {super.key, required this.text, this.onTap, required this.switchText});
  final String text;
  final String switchText;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(switchText),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: const TextStyle(color: AppColors.blue),
          ),
        ),
      ],
    );
  }
}
