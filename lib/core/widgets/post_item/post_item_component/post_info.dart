import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/feautures/bussines_logic/comment_cubit/comment_cubit.dart';
import 'package:iamtalking/feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/feautures/data/models/comment_model.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';

import '../../../routes/route_strings.dart';

// ignore: must_be_immutable
class PostInfo extends StatelessWidget {
  PostInfo({super.key, required this.post, required this.user});
  PostModel post;
  UserAuthModel user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            IconButton(
              onPressed: () async {
                await BlocProvider.of<PostBloc>(context)
                    .likePost(post.postId, post.likes);
              },
              icon: Icon(
                Icons.favorite_outline,
                color: post.likes.contains(auth.currentUser!.uid)
                    ? Colors.red
                    : null,
              ),
            ),
            Text(
              post.likes.length.toString(),
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  commentViewRoute,
                  arguments: [
                    post,
                  ],
                );
              },
              icon: const Icon(Icons.comment_outlined),
            ),
            StreamBuilder<List<CommentModel>>(
                stream: BlocProvider.of<CommentBloc>(context)
                    .getComments(post.postId),
                builder: (context, comments) {
                  if (comments.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (comments.hasError) {
                    return Text(comments.error.toString());
                  }
                  return Text(comments.data!.length.toString());
                },),
          ],
        ),
        const Spacer(),
        Text(
          BlocProvider.of<PostBloc>(context).formatDate(
            post.createdAt.toDate(),
          ),
        ).padding(10.w, 0),
      ],
    );
  }
}
