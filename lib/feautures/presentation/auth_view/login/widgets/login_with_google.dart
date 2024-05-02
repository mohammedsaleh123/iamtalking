import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/generated/l10n.dart';

class LogInWithGoogle extends StatelessWidget {
  const LogInWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).or),
        Text(
          S.of(context).login_with_Google,
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {},
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.sp),
              child: Image.asset('assets/icons/google.png',
                  height: 35.h, width: 35.w)),
        ),
      ],
    );
  }
}
