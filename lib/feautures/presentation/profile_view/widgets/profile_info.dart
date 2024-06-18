import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/core/utils/app_colors.dart';
import 'package:iamtalking/generated/l10n.dart';

import '../../../../core/routes/route_strings.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot<UserAuthModel> snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                snapshot.data!.userName,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ).padding(20.w, 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        followersViewRoute,
                        arguments: [snapshot.data],
                      );
                    },
                    child: Text(
                      S.of(context).followers,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Divider(
                    color: AppColors.white,
                    height: 10.h,
                  ),
                  Text(
                    snapshot.data!.followers!.length.toString(),
                  )
                ],
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        followingViewRoute,
                        arguments: [snapshot.data],
                      );
                    },
                    child: Text(
                      S.of(context).following,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Divider(
                    color: AppColors.white,
                    height: 10.h,
                  ),
                  Text(
                    snapshot.data!.following!.length.toString(),
                  )
                ],
              ),
            ],
          ).padding(20.w, 0),
        ],
      ),
    );
  }
}
