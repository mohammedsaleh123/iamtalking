import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/utils/app_colors.dart';
import 'package:iamtalking/core/widgets/custom_shimmer.dart';
import 'package:iamtalking/feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class PostMedia extends StatelessWidget {
  PostMedia({
    super.key,
    required this.posts,
  });

  PostModel posts;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.sp)),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        child: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {},
          builder: (context, state) {
            final postBloc = BlocProvider.of<PostBloc>(context);
            return ClipRRect(
              borderRadius: BorderRadius.circular(30.sp),
              child: posts.postVideo == ''
                  ? CachedNetworkImage(
                      placeholder: (context, url) {
                        return CustomShimmer(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                        );
                      },
                      imageUrl: posts.postImage,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                    )
                  : Stack(
                      children: [
                        VideoPlayer(postBloc.videoController!),
                        Center(
                          child: IconButton(
                            onPressed: () {
                              postBloc.changePlayState();
                              if (postBloc.isPlay) {
                                postBloc.videoController!.play();
                              } else {
                                postBloc.videoController!.pause();
                              }
                            },
                            icon: postBloc.isPlay
                                ? const Icon(Icons.pause)
                                : Icon(
                                    Icons.play_arrow,
                                    size: 40.sp,
                                    color: AppColors.yellow,
                                  ),
                          ),
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
