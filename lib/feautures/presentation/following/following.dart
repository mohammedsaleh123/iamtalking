import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';

import '../../../core/routes/route_strings.dart';
import '../../../core/widgets/custom_shimmer.dart';
import '../../../generated/l10n.dart';
import '../../bussines_logic/user_cubit/user_cubit.dart';

// ignore: must_be_immutable
class Following extends StatelessWidget {
  Following({super.key, required this.user});
  UserAuthModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).following),
      ),
      body: ListView.builder(
        itemCount: user.following!.length,
        itemBuilder: (context, index) {
          return StreamBuilder<UserAuthModel>(
            stream: BlocProvider.of<UserBloc>(context)
                .getUser(user.following![index]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const SizedBox();
              }
              return ListTile(
                title: Text(snapshot.data!.userName),
                subtitle: Text(snapshot.data!.email),
                leading: CircleAvatar(
                  radius: 25.sp,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.sp),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data!.profileImage,
                      placeholder: (context, url) =>
                          CustomShimmer(height: 50.h, width: 50.w),
                      fit: BoxFit.fill,
                      height: 50.h,
                      width: 50.w,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    userProfileViewRoute,
                    arguments: snapshot.data!.uid,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
