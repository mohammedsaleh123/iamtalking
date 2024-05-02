import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/core/routes/route_strings.dart';
import 'package:iamtalking/feautures/bussines_logic/auth_cubit/auth_cubit.dart';
import 'package:iamtalking/feautures/presentation/auth_view/login/widgets/login_button.dart';
import 'package:iamtalking/feautures/presentation/auth_view/login/widgets/login_with_google.dart';
import 'package:iamtalking/feautures/presentation/auth_view/widgets/auth_banner.dart';
import 'package:iamtalking/feautures/presentation/auth_view/widgets/email_field.dart';
import 'package:iamtalking/feautures/presentation/auth_view/widgets/password_field.dart';
import 'package:iamtalking/feautures/presentation/auth_view/widgets/swith_betwen_login_and_register.dart';
import 'package:iamtalking/generated/l10n.dart';

// ignore: must_be_immutable
class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: cubit.loginFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthBanner(),
                EmailField(
                  emailController: cubit.loginEmailController,
                ).padding(0, 14.h),
                PasswordField(
                        passwordController: cubit.loginPasswordController,
                        obsecureText: true)
                    .padding(0, 14.h),
                SwitchBetwenLogInAndRegister(
                  text: S.of(context).register,
                  switchText: S.of(context).new_remember,
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(registerViewRoute);
                  },
                ).padding(0, 14.h),
                const LogInWithGoogle().padding(0, 14.h),
                const LogInButton().padding(0, 14.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
