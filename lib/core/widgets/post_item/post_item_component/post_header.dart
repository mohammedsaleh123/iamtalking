import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:iamtalking/generated/l10n.dart';
import 'package:toast/toast.dart';

import '../../../routes/route_strings.dart';
import '../../../utils/app_colors.dart';
import '../../custom_shimmer.dart';

// ignore: must_be_immutable
class PostHeader extends StatelessWidget {
  PostHeader({
    super.key,
    required this.post,
    required this.user,
  });
  PostModel post;
  UserAuthModel user;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed(
              userProfileViewRoute,
              arguments: post.userId,
            );
          },
          child: CircleAvatar(
            radius: 25.sp,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.sp),
              child: CachedNetworkImage(
                imageUrl: post.userImage,
                fit: BoxFit.cover,
                height: 50.h,
                width: 50.w,
                placeholder: (context, url) {
                  return CustomShimmer(
                    height: 50.h,
                    width: 50.w,
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Text(post.userName),
        const Spacer(),
        DropdownButton(
          icon: const Icon(Icons.more_vert_outlined),
          items: post.userId == user.uid
              ? [
                  DropdownMenuItem(
                    value: S.of(context).delete,
                    child: Text(
                      S.of(context).delete,
                    ),
                  ),
                  DropdownMenuItem(
                    value: S.of(context).edit,
                    child: Text(
                      S.of(context).edit,
                    ),
                  ),
                ]
              : [
                  DropdownMenuItem(
                    value: post.savedPost.contains(user.uid)
                        ? S.of(context).un_save_post
                        : S.of(context).save_post,
                    child: Text(post.savedPost.contains(user.uid)
                        ? S.of(context).un_save_post
                        : S.of(context).save_post),
                  ),
                ],
          onChanged: (value) {
            if (value == S.of(context).delete) {
              BlocProvider.of<PostBloc>(context)
                  .deletePost(post.postId, post.imagePath);
              Toast.show(
                S.of(context).delete_post_successfully,
                duration: Toast.lengthShort,
                gravity: Toast.bottom,
                backgroundColor: AppColors.blue,
              );
            } else if (value == S.of(context).edit) {
              Navigator.pushNamed(
                context,
                editPostViewRoute,
                arguments: post,
              );
            } else if (value == S.of(context).save_post) {
              BlocProvider.of<PostBloc>(context).savePost(post, user.uid);
              Toast.show(
                S.of(context).save_post_successfully,
                duration: Toast.lengthShort,
                gravity: Toast.bottom,
                backgroundColor: AppColors.blue,
              );
            } else if (value == S.of(context).un_save_post) {
              BlocProvider.of<PostBloc>(context).unSavePost(post, user.uid);
              Toast.show(
                S.of(context).un_save_post_successfully,
                duration: Toast.lengthShort,
                gravity: Toast.bottom,
                backgroundColor: AppColors.blue,
              );
            }
          },
        ),
      ],
    );
  }
}
