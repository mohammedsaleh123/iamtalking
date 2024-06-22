import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hintText,
    required this.textController,
    this.validator,
    this.textInputType,
    this.obsecureText,
    this.prefixWidget,
    this.suffixIcon,
  });
  final String hintText;
  TextEditingController textController = TextEditingController();
  String? Function(String?)? validator;
  TextInputType? textInputType;
  Widget? prefixWidget;
  Widget? suffixIcon;
  bool? obsecureText;
  void Function(String)? onChanged;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText ?? false,
      controller: textController,
      validator: validator,
      keyboardType: textInputType,
      onChanged: onChanged,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixWidget,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.sp),
        ),
        hintStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
