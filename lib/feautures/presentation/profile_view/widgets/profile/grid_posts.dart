import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';

import '../../../../../core/routes/route_strings.dart';
import '../../../../../core/widgets/custom_shimmer.dart';
import '../../../../data/models/post_model.dart';
import '../../../../data/models/user_auth_model.dart';

class GridPosts extends StatelessWidget {
  const GridPosts({
    super.key,
    required this.userPosts,
    required this.snapshot,
  });

  final List<PostModel> userPosts;
  final AsyncSnapshot<UserAuthModel> snapshot;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const PageStorageKey('gridPosts'),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1.h,
        crossAxisSpacing: 1.h,
      ),
      itemCount: userPosts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed(
              userPostsViewRoute,
              arguments: [
                userPosts[index].postId,
                snapshot.data!.uid,
              ],
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.sp),
            child: CachedNetworkImage(
              imageUrl: userPosts[index].postImage,
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
          ).padding(4.w, 4.h),
        );
      },
    );
  }
}
