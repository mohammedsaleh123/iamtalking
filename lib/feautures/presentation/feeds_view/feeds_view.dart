import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'package:iamtalking/feautures/bussines_logic/user_cubit/user_cubit.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:iamtalking/feautures/presentation/drawer_view/custom_drawer.dart';
import 'package:iamtalking/core/widgets/post_item/post_item.dart';
import 'package:iamtalking/generated/l10n.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).feeds),
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
            return StreamBuilder<UserAuthModel>(
                stream: BlocProvider.of<UserBloc>(context)
                    .getUser(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const SizedBox();
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 20.sp),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.sp),
                        topRight: Radius.circular(40.sp),
                      ),
                    ),
                    child: ListView.separated(
                      key: const PageStorageKey('feeds'),
                      addAutomaticKeepAlives: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 3.sp,
                          indent: 10.sp,
                          endIndent: 10.sp,
                        );
                      },
                      itemCount:
                          posts.data!.isNotEmpty ? posts.data!.length : 0,
                      itemBuilder: (context, index) {
                        return PostItem(
                          posts: posts.data![index],
                          user: snapshot.data!,
                        );
                      },
                    ),
                  );
                });
          }),
      drawer: const CustomDrawer(),
    );
  }
}
