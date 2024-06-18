import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/core/utils/app_colors.dart';
import 'package:iamtalking/core/widgets/custom_button.dart';
import 'package:iamtalking/core/widgets/custom_text_field.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:iamtalking/feautures/presentation/add_post_view/widgets/choose_post_media.dart';
import 'package:iamtalking/feautures/presentation/add_post_view/widgets/post_media.dart';
import 'package:iamtalking/generated/l10n.dart';
import 'package:toast/toast.dart';

import '../../bussines_logic/user_cubit/user_cubit.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).add_post),
            actions: [
               IconButton(
                    onPressed: () {
                      BlocProvider.of<PostBloc>(context).clearPostField();
                    },
                    icon: const Icon(Icons.close),
                  ),
            ],
          ),
          body: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is AddPostSuccess) {
                Toast.show(
                  S.of(context).add_post_successfully,
                  duration: Toast.lengthShort,
                  gravity: Toast.bottom,
                  backgroundColor: AppColors.blue,
                );
              }
            },
            builder: (context, state) {
              final cubit = BlocProvider.of<PostBloc>(context);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const PostMedia(),
                    ChoosePostMedia(cubit: cubit),
                    CustomTextField(
                      hintText: S.of(context).add_caption,
                      textController: cubit.captionController,
                    ).padding(0, 20.h),
                    StreamBuilder<UserAuthModel>(
                        stream:
                            BlocProvider.of<UserBloc>(context).getCurrentUser(),
                        builder: (context, user) {
                          return CustomButton(
                            onPressed: () {
                              cubit.addPost(user.data!);
                            },
                            color: AppColors.blue,
                            radius: 20.sp,
                            minWidth: double.infinity,
                            child: state is AddPostLoading
                                ? const CircularProgressIndicator()
                                    .padding(0, 15.h)
                                : Text(
                                    S.of(context).add_post,
                                  ).padding(0, 15.h),
                          );
                        }),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
