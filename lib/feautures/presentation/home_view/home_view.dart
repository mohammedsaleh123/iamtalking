import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/feautures/presentation/add_post_view/add_post_view.dart';
import 'package:iamtalking/feautures/presentation/feeds_view/feeds_view.dart';
import 'package:iamtalking/feautures/presentation/saved_posts_view/saved_posts_view.dart';
import 'package:iamtalking/generated/l10n.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../profile_view/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPageIndex = 0;
  List<Widget> pages = [
    const FeedsView(),
    const ProfileView(),
    const AddPostView(),
    SavedPostsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      floatingActionButton: Container(
        height: 70.h,
        width: double.infinity,
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: currentPageIndex,
          selectedItemColor: Theme.of(context).primaryColorLight,
          unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.6),
          iconSize: 30.sp,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: S.of(context).feeds,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.analytics),
              label: S.of(context).profile,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.analytics),
              label: S.of(context).add_post,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.analytics),
              label: S.of(context).saved_posts,
            ),
          ],
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
