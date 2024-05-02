import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iamtalking/feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'package:video_player/video_player.dart';

class PostMedia extends StatelessWidget {
  const PostMedia({
    super.key,
    required this.cubit,
  });

  final PostBloc cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: cubit.postImage == null
          ? cubit.postImageToEdit != ""
              ? CachedNetworkImage(
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  imageUrl: cubit.postImageToEdit,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                )
              //  Image.network(
              //     cubit.postImageToEdit,
              //     fit: BoxFit.cover,
              //     height: MediaQuery.of(context).size.height * 0.4,
              //     width: double.infinity,
              //   )
              : const SizedBox()
          : cubit.isVideo == false
              ? Image.file(
                  cubit.postImage!,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                )
              : VideoPlayer(cubit.videoController!),
    );
  }
}
