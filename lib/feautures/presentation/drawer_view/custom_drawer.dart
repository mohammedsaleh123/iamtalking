import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iamtalking/core/app_bussines_logic/cubit/app_cubit.dart';
import 'package:iamtalking/core/routes/route_strings.dart';
import 'package:iamtalking/feautures/bussines_logic/auth_cubit/auth_cubit.dart';
import 'package:iamtalking/generated/l10n.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthBloc>(context);
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                S.of(context).logout,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.logout),
              onTap: () {
                authCubit.logout().then(
                      (value) => Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed(
                        loginViewRoute,
                      ),
                    );
              },
            ),
            ListTile(
              title: Text(
                BlocProvider.of<AppBloc>(context).isDark
                    ? S.of(context).light_theme
                    : S.of(context).dark_theme,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.sunny),
              onTap: () {
                BlocProvider.of<AppBloc>(context).changeTheme();
              },
            ),
            ListTile(
              title: Text(
                S.of(context).language,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.language),
              onTap: () {
                BlocProvider.of<AppBloc>(context).changeLanguage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
