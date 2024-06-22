import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/constants/app_strings.dart';
import 'package:iamtalking/core/utils/app_colors.dart';
import 'package:iamtalking/feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'package:iamtalking/generated/l10n.dart';

class ChoosePostMedia extends StatelessWidget {
  const ChoosePostMedia({
    super.key,
    required this.cubit,
  });

  final PostBloc cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton(
          icon: Icon(
            Icons.photo,
            size: 30.sp,
            color: AppColors.blue,
          ),
          hint: Text(
            S.of(context).choose_image,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          items: [
            DropdownMenuItem(
              value: AppStrings.camera,
              child: Row(
                children: [
                  Text(S.of(context).camera),
                  SizedBox(width: 10.w),
                  const Icon(
                    Icons.camera,
                    color: AppColors.red,
                  )
                ],
              ),
            ),
            DropdownMenuItem(
              value: AppStrings.gallery,
              child: Row(
                children: [
                  Text(S.of(context).gallery),
                  SizedBox(width: 10.w),
                  const Icon(
                    Icons.photo_library,
                    color: AppColors.blue,
                  )
                ],
              ),
            ),
          ],
          onChanged: (value) {
            if (value == AppStrings.camera) {
              cubit.uploadPostImage(AppStrings.image, AppStrings.camera);
            } else {
              cubit.uploadPostImage(AppStrings.image, AppStrings.gallery);
            }
          },
        ),
        SizedBox(width: 20.w),
        DropdownButton(
          icon: Icon(
            Icons.video_camera_back,
            size: 30.sp,
            color: AppColors.red,
          ),
          hint: Text(
            S.of(context).choose_video,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          items: [
            DropdownMenuItem(
              value: AppStrings.camera,
              child: Row(
                children: [
                  Text(S.of(context).camera),
                  SizedBox(width: 10.w),
                  const Icon(
                    Icons.camera,
                    color: AppColors.red,
                  )
                ],
              ),
            ),
            DropdownMenuItem(
              value: AppStrings.gallery,
              child: Row(
                children: [
                  Text(S.of(context).gallery),
                  SizedBox(width: 10.w),
                  const Icon(
                    Icons.photo_library,
                    color: AppColors.blue,
                  )
                ],
              ),
            ),
          ],
          onChanged: (value) {
            if (value == AppStrings.camera) {
              cubit.uploadPostImage(AppStrings.video, AppStrings.camera);
            } else {
              cubit.uploadPostImage(AppStrings.video, AppStrings.gallery);
            }
          },
        ),
      ],
    );
  }
}
