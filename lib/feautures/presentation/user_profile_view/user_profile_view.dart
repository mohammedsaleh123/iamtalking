import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/center_extension.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';

import '../../../core/routes/route_strings.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../generated/l10n.dart';
import '../../bussines_logic/user_cubit/user_cubit.dart';
import '../../data/models/user_auth_model.dart';
import '../profile_view/widgets/profile_info.dart';
import '../profile_view/widgets/profile_posts.dart';

// ignore: must_be_immutable
class UserProfileView extends StatelessWidget {
  UserProfileView({super.key, required this.userId});
  String userId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserAuthModel>(
      stream: BlocProvider.of<UserBloc>(context).getUser(userId),
      builder: (context, userProfile) {
        if (userProfile.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (userProfile.hasError) {
          return const SizedBox();
        }
        return Scaffold(
          appBar: AppBar(
              title: Text(userProfile.data!.userName),
              centerTitle: true,
              actions: [
                if (userId != FirebaseAuth.instance.currentUser!.uid)
                  IconButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        chatViewRoute,
                        arguments: [userProfile.data!],
                      );
                    },
                    icon: const Icon(Icons.messenger,
                        color: AppColors.blue, size: 30),
                  )
              ]),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ProfileInfo(snapshot: userProfile),
              CustomButton(
                onPressed: () {
                  if (userProfile.data!.followers!
                      .contains(FirebaseAuth.instance.currentUser!.uid)) {
                    BlocProvider.of<UserBloc>(context).unfollowUser(userId);
                  } else {
                    BlocProvider.of<UserBloc>(context).followUser(userId);
                  }
                },
                color: AppColors.grey.withOpacity(0.5),
                radius: 20.sp,
                minWidth: double.infinity,
                child: buttonChild(context, userProfile),
              ).padding(5.w, 10.h).center(),
              ProfilePosts(snapshot: userProfile),
            ],
          ),
        );
      },
    );
  }

  Widget buttonChild(
      BuildContext context, AsyncSnapshot<UserAuthModel> userProfile) {
    if (userProfile.data!.uid == FirebaseAuth.instance.currentUser!.uid) {
      return Text(S.of(context).edit_profile).padding(0, 10.h);
    } else {
      if (userProfile.data!.followers!
          .contains(FirebaseAuth.instance.currentUser!.uid)) {
        return Text(S.of(context).un_follow).padding(0, 10.h);
      } else {
        return Text(S.of(context).follow).padding(0, 10.h);
      }
    }
  }
}
