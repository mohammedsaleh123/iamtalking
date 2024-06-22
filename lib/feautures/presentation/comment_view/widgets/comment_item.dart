import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/center_extension.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_shimmer.dart';
import '../../../../generated/l10n.dart';
import '../../../bussines_logic/comment_cubit/comment_cubit.dart';
import '../../../data/models/comment_model.dart';

// ignore: must_be_immutable
class CommentItem extends StatelessWidget {
  CommentItem({
    super.key,
    required this.comments,
    required this.postId,
  });
  CommentModel comments;
  String postId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        if (comments.userId == FirebaseAuth.instance.currentUser!.uid) {
          showDialog(
            context: context,
            builder: (context) {
              return BlocBuilder<CommentBloc, CommentState>(
                builder: (context, state) {
                  return AlertDialog(
                    alignment: Alignment.center,
                    title: Text(
                      S.of(context).delete_comment,
                    ).center(),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<CommentBloc>(context)
                              .deleteComment(postId, comments.commentId);
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).delete),
                      ),
                    ],
                  );
                },
              );
            },
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16.r,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: CachedNetworkImage(
                height: 100.h,
                width: 100.w,
                placeholder: (context, url) => CustomShimmer(
                  height: 100.h,
                  width: 100.w,
                ),
                imageUrl: comments.userImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.grey.withOpacity(0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comments.userName,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 5.h),
                      ExpandableText(
                        comments.comment,
                        expandText: S.of(context).more,
                        collapseText: S.of(context).less,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 12.sp,
                            ),
                        linkStyle: Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium!
                            .copyWith(
                              color: AppColors.blue,
                            ),
                      ),
                    ],
                  ),
                ),
                if (comments.commentImage != '')
                  CachedNetworkImage(
                    height: 200.h,
                    width: 200.w,
                    imageUrl: comments.commentImage!,
                    placeholder: (context, url) => CustomShimmer(
                      height: 50.h,
                      width: 50.w,
                    ),
                  ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline),
                    ),
                    Text('${comments.likes.length} ${S.of(context).likes}'),
                    SizedBox(width: 10.w),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.comment_outlined),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ).padding(10.w, 10.h),
    );
  }
}
