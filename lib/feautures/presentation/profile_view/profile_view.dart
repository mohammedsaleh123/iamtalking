import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/center_extension.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/core/utils/app_colors.dart';
import 'package:iamtalking/core/widgets/custom_button.dart';
import 'package:iamtalking/feautures/bussines_logic/user_cubit/user_cubit.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:iamtalking/feautures/presentation/profile_view/widgets/profile_info.dart';
import 'package:iamtalking/feautures/presentation/profile_view/widgets/profile_posts.dart';
import 'package:iamtalking/generated/l10n.dart';

import '../drawer_view/custom_drawer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile),
      ),
      body: StreamBuilder<UserAuthModel>(
        stream: UserBloc.get(context).getCurrentUser(),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ProfileInfo(snapshot: snapshot),
              CustomButton(
                onPressed: () {},
                color: AppColors.grey.withOpacity(0.5),
                radius: 20.sp,
                minWidth: double.infinity,
                child: Text(S.of(context).edit_profile).padding(0, 10.h),
              ).padding(5.w, 10.h).center(),
              ProfilePosts(snapshot: snapshot),
            ],
          );
        },
      ),
      drawer: const CustomDrawer(),
    );
  }
}
