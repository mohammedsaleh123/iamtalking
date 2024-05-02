import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/widgets/custom_shimmer.dart';
import 'package:iamtalking/feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/core/utils/app_colors.dart';
import 'package:iamtalking/generated/l10n.dart';
import 'profile/grid_posts.dart';

class ProfilePosts extends StatelessWidget {
  const ProfilePosts({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot<UserAuthModel> snapshot;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
      stream: BlocProvider.of<PostBloc>(context).getAllPosts(),
      builder: (context, posts) {
        if (posts.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (posts.hasError) {
          return const SizedBox();
        }
        final userPosts = posts.data!
            .where((post) => post.userId == snapshot.data!.uid)
            .toList();
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                child: Container(
                  padding: EdgeInsets.only(top: 100.sp),
                  margin: EdgeInsets.only(top: 40.sp),
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.sp),
                      topRight: Radius.circular(40.sp),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.sp),
                        topRight: Radius.circular(40.sp),
                      ),
                    ),
                    child: GridPosts(userPosts: userPosts, snapshot: snapshot),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 20.sp,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 60.sp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.sp),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data!.profileImage,
                              fit: BoxFit.fill,
                              height: 120.h,
                              width: 120.w,
                              placeholder: (context, url) {
                                return CustomShimmer(
                                  height: 120.h,
                                  width: 120.w,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70.sp,
                        ),
                        Text(
                          '${userPosts.length}  ${S.of(context).posts}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 15.sp,
                                  ),
                        ),
                      ],
                    ).padding(0, 15.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
