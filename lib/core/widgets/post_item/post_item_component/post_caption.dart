// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/widgets/custom_shimmer.dart';
import 'package:iamtalking/feautures/bussines_logic/user_cubit/user_cubit.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';

import '../../../../generated/l10n.dart';

class PostCaption extends StatelessWidget {
  PostCaption({
    super.key,
    required this.posts,
  });
  PostModel posts;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder<UserAuthModel>(
            stream: UserBloc.get(context).getUser(posts.userId),
            builder: (context, currentUser) {
              if (currentUser.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (currentUser.hasError) {
                return const SizedBox();
              }
              return CircleAvatar(
                radius: 15.sp,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17.sp),
                  child: CachedNetworkImage(
                    imageUrl: currentUser.data!.profileImage,
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
              );
            }),
        SizedBox(width: 20.w),
        Expanded(
          child: ExpandableText(
            posts.caption!,
            expandText: S.of(context).more,
            maxLines: 1,
            collapseText: S.of(context).less,
          ),
        ),
      ],
    );
  }
}
