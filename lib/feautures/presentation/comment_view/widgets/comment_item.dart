import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_shimmer.dart';
import '../../../../generated/l10n.dart';
import '../../../data/models/comment_model.dart';

// ignore: must_be_immutable
class CommentItem extends StatelessWidget {
  CommentItem({
    super.key,
    required this.comments,
  });
  CommentModel comments;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).delete_comment,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    S.of(context).edit_comment,
                  )
                ],
              ),
            );
          },
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16.r,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: CachedNetworkImage(
                height: 50.h,
                width: 50.w,
                placeholder: (context, url) => CustomShimmer(
                  height: 50.h,
                  width: 50.w,
                ),
                imageUrl: comments.userImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
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
