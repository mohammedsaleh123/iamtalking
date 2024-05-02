import 'package:flutter/material.dart';
import 'package:iamtalking/core/routes/route_strings.dart';
import 'package:iamtalking/feautures/data/models/post_model.dart';
import 'package:iamtalking/feautures/presentation/auth_view/login/login_view.dart';
import 'package:iamtalking/feautures/presentation/auth_view/register/register_view.dart';
import 'package:iamtalking/feautures/presentation/edit_post_view/edit_post_view.dart';
import 'package:iamtalking/feautures/presentation/home_view/home_view.dart';
import 'package:iamtalking/feautures/presentation/user_profile_view/user_profile_view.dart';

import '../../feautures/data/models/user_auth_model.dart';
import '../../feautures/presentation/chat_view/chat_view.dart';
import '../../feautures/presentation/comment_view/comment_view.dart';
import '../../feautures/presentation/user_posts_view/user_posts_view.dart';

class AppRoute {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeViewRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case loginViewRoute:
        return MaterialPageRoute(
          builder: (_) => const LogInView(),
        );
      case registerViewRoute:
        return MaterialPageRoute(
          builder: (_) => const RegisterView(),
        );
      case editPostViewRoute:
        final post = settings.arguments as PostModel;
        return MaterialPageRoute(
          builder: (_) => EditPostView(post: post),
        );
      case userProfileViewRoute:
        final userId = settings.arguments as String;
        return PageRouteBuilder(
          pageBuilder: (context, animation, ___) {
            return UserProfileView(userId: userId);
          },
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case userPostsViewRoute:
        final List<dynamic> args = settings.arguments as List<dynamic>;
        final postId = args[0] as String;
        final userId = args[1] as String;
        return MaterialPageRoute(
          builder: (_) => UserPostsView(
            postId: postId,
            userId: userId,
          ),
        );
      case commentViewRoute:
        final List<dynamic> args = settings.arguments as List<dynamic>;
        final post = args[0] as PostModel;
        return PageRouteBuilder(
          pageBuilder: (_, a, __) {
            return CommentView(post: post);
          },
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case chatViewRoute:
        final List<dynamic> args = settings.arguments as List<dynamic>;
        final otherUser = args[0] as UserAuthModel;
        return PageRouteBuilder(
          pageBuilder: (_, a, __) {
            return ChatView(
              otherUser: otherUser,
            );
          },
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
    }
    return null;
  }
}
