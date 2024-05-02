import 'package:flutter/material.dart';
import 'package:iamtalking/core/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class CustomShimmer extends StatelessWidget {
  CustomShimmer({super.key, required this.height, required this.width});
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(colors: [
        AppColors.white,
        AppColors.grey,
        AppColors.grey,
        AppColors.deepGrey
      ]),
      child: Container(
        height: height,
        width: width,
        color: AppColors.grey,
      ),
    );
  }
}
