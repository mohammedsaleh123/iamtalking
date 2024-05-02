import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iamtalking/core/widgets/post_item/post_item.dart';

import '../../bussines_logic/post_cubit/post_cubit.dart';
import '../../bussines_logic/user_cubit/user_cubit.dart';
import '../../data/models/post_model.dart';
import '../../data/models/user_auth_model.dart';

class UserPostsView extends StatelessWidget {
  const UserPostsView({
    super.key,
    required this.postId,
    required this.userId,
  });
  final String postId;
  final String userId;

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
        final userPosts =
            posts.data!.where((element) => element.userId == userId).toList();
        return StreamBuilder<UserAuthModel>(
            stream: BlocProvider.of<UserBloc>(context).getUser(userId),
            builder: (context, user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (user.hasError) {
                return const SizedBox();
              }
              return Scaffold(
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          key: const PageStorageKey('userPosts'),
                          itemCount: userPosts.length,
                          itemBuilder: (context, index) {
                            return PostItem(
                                posts: userPosts[index], user: user.data!);
                          }),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
