import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/generated/l10n.dart';

import 'core/app_bussines_logic/cubit/app_cubit.dart';
import 'core/routes/app_route.dart';
import 'core/routes/route_strings.dart';
import 'core/services/services_locator.dart';
import 'core/theme/app_theme.dart';
import 'feautures/bussines_logic/auth_cubit/auth_cubit.dart';
import 'feautures/bussines_logic/chat_cubit/chat_cubit.dart';
import 'feautures/bussines_logic/comment_cubit/comment_cubit.dart';
import 'feautures/bussines_logic/post_cubit/post_cubit.dart';
import 'feautures/bussines_logic/user_cubit/user_cubit.dart';

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(create: (context) => sl<AppBloc>()),
        BlocProvider<UserBloc>(create: (context) => sl<UserBloc>()),
        BlocProvider<PostBloc>(create: (context) => sl<PostBloc>()),
        BlocProvider<CommentBloc>(create: (context) => sl<CommentBloc>()),
        BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
        BlocProvider<ChatBloc>(create: (context) => sl<ChatBloc>()),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final size = MediaQuery.of(context).size;
          return ScreenUtilInit(
            designSize:  Size(size.width, size.height),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (screen, child) {
              final currentLocale =
                  Locale(BlocProvider.of<AppBloc>(context).language);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'i"am talking',
                theme: BlocProvider.of<AppBloc>(context).isDark
                    ? darkTheme(context)
                    : lightTheme(context),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: currentLocale,
                onGenerateRoute: AppRoute().generateRoute,
                initialRoute:
                    auth.currentUser == null ? loginViewRoute : homeViewRoute,
              );
            },
          );
        },
      ),
    );
  }
}
