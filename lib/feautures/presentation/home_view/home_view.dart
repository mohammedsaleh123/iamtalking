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
  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: const FeedsView(),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: S.of(context).feeds,
          ),
        ),
        PersistentTabConfig(
          screen: const ProfileView(),
          item: ItemConfig(
            icon: const Icon(Icons.person),
            title: S.of(context).profile,
          ),
        ),
        PersistentTabConfig(
          screen: const AddPostView(),
          item: ItemConfig(
            icon: const Icon(Icons.add),
            title: S.of(context).add_post,
          ),
        ),
        PersistentTabConfig(
          screen: SavedPostsView(),
          item: ItemConfig(
            icon: const Icon(Icons.save),
            title: S.of(context).saved_posts,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        screenTransitionAnimation: const ScreenTransitionAnimation(
            duration: Durations.short4, curve: Curves.linear),
        tabs: _tabs(),
        navBarBuilder: (NavBarConfig navBarConfig) {
          return Style8BottomNavBar(
            navBarConfig: navBarConfig,
            navBarDecoration: NavBarDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(24.sp),
            ),
          );
        },
      ),
    );
  }
}
