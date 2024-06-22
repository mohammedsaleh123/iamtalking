import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/core/widgets/post_item/post_item_component/post_info.dart';
import 'package:iamtalking/core/widgets/post_item/post_item_component/post_media.dart';
import 'package:iamtalking/core/widgets/post_item/post_item_component/post_caption.dart';
import 'package:iamtalking/core/widgets/post_item/post_item_component/post_header.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';

// ignore: must_be_immutable
class PostItem extends StatelessWidget {
  PostItem({
    super.key,
    required this.posts,
    required this.user,
  });
  PostModel posts;
  UserAuthModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      padding: EdgeInsets.all(10.sp),
      height: MediaQuery.of(context).size.height * 0.55,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PostHeader(
            post: posts,
            user: user,
          ),
          PostMedia(posts: posts),
          SizedBox(
              child: posts.caption == ''
                  ? const SizedBox()
                  : PostCaption(posts: posts).padding(5.w, 5.h)),
          PostInfo(post: posts, user: user),
        ],
      ),
    );
  }
}
