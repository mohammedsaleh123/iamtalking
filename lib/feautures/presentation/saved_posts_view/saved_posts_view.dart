import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iamtalking/feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/core/widgets/post_item/post_item.dart';
import 'package:iamtalking/generated/l10n.dart';

import '../../bussines_logic/user_cubit/user_cubit.dart';
import '../../data/models/user_auth_model.dart';

// ignore: must_be_immutable
class SavedPostsView extends StatelessWidget {
  SavedPostsView({super.key});
  FirebaseAuth user = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).saved_posts),
      ),
      body: StreamBuilder<List<PostModel>>(
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
          List<PostModel> savedPosts = posts.data!
              .where((post) => post.savedPost.contains(user.currentUser!.uid))
              .toList();
          return StreamBuilder<UserAuthModel>(
              stream: BlocProvider.of<UserBloc>(context)
                  .getUser(posts.data!.map((e) => e.userId).first),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const SizedBox();
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: savedPosts.length,
                        itemBuilder: (context, index) {
                          return PostItem(
                              posts: savedPosts[index], user: snapshot.data!);
                        },
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
