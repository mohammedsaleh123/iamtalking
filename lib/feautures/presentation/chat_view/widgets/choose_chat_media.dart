import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../bussines_logic/chat_cubit/chat_cubit.dart';

class ChooseChatMedia extends StatelessWidget {
  const ChooseChatMedia({
    super.key,
    required this.chatCubit,
  });

  final ChatBloc chatCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton(
            icon: Icon(
              Icons.photo,
              size: 20.sp,
              color: AppColors.blue,
            ),
            hint: Text(
              S.of(context).choose_image,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 13.sp),
            ),
            items: [
              DropdownMenuItem(
                value: AppStrings.camera,
                child: Row(
                  children: [
                    Text(S.of(context).camera),
                    SizedBox(width: 5.w),
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
                    SizedBox(width: 5.w),
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
                chatCubit.uploadPostImage(AppStrings.image, AppStrings.camera);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } else {
                chatCubit.uploadPostImage(AppStrings.image, AppStrings.gallery);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
          SizedBox(width: 10.w),
          DropdownButton(
            icon: Icon(
              Icons.video_camera_back,
              size: 20.sp,
              color: AppColors.red,
            ),
            hint: Text(
              S.of(context).choose_video,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 13.sp),
            ),
            items: [
              DropdownMenuItem(
                value: AppStrings.camera,
                child: Row(
                  children: [
                    Text(S.of(context).camera),
                    SizedBox(width: 5.w),
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
                    SizedBox(width: 5.w),
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
                chatCubit.uploadPostImage(AppStrings.video, AppStrings.camera);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } else {
                chatCubit.uploadPostImage(AppStrings.video, AppStrings.gallery);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
