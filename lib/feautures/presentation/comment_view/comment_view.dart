import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/core/widgets/custom_text_field.dart';
import 'package:iamtalking/feautures/bussines_logic/comment_cubit/comment_cubit.dart';
import 'package:iamtalking/feautures/bussines_logic/user_cubit/user_cubit.dart';
import 'package:iamtalking/feautures/data/models/comment_model.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';

import '../../../generated/l10n.dart';
import 'widgets/comment_item.dart';

// ignore: must_be_immutable
class CommentView extends StatelessWidget {
  CommentView({super.key, required this.post});
  PostModel post;

  @override
  Widget build(BuildContext context) {
    final commentCubit = BlocProvider.of<CommentBloc>(context);

    final userCubit = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${post.userName} ${S.of(context).comments.toLowerCase()}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<List<CommentModel>>(
            stream: commentCubit.getComments(post.postId),
            builder: (context, comments) {
              if (comments.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (comments.hasError) {
                return Text(comments.error.toString());
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: comments.data!.length,
                  itemBuilder: (context, index) {
                    return CommentItem(
                      comments: comments.data![index],
                    );
                  },
                ),
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  hintText: S.of(context).add_comment,
                  textController: commentCubit.commentController,
                ).padding(10.w, 10.h),
              ),
              StreamBuilder<UserAuthModel>(
                stream: userCubit.getCurrentUser(),
                builder: (context, user) {
                  return IconButton(
                    onPressed: () {
                      commentCubit.addComment(
                        post.postId,
                        user.data!,
                      );
                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(Icons.send),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
