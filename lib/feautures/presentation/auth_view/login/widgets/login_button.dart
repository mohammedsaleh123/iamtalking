import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/routes/route_strings.dart';
import 'package:iamtalking/feautures/bussines_logic/auth_cubit/auth_cubit.dart';
import 'package:iamtalking/core/extensions/center_extension.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/core/utils/app_colors.dart';
import 'package:iamtalking/core/widgets/custom_button.dart';
import 'package:iamtalking/generated/l10n.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class LogInButton extends StatelessWidget {
  const LogInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Toast.show(
            S.of(context).login_successfully,
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: AppColors.blue,
          );
          Navigator.of(context).pushReplacementNamed(homeViewRoute);
        }
        if (state is LoginFailed) {
          Toast.show(
            S.of(context).login_failed,
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: AppColors.blue,
          );
        }
      },
      builder: (context, state) {
        final authCubit = BlocProvider.of<AuthBloc>(context);

        return CustomButton(
          onPressed: () {
            if (authCubit.loginFormKey.currentState!.validate()) {
              authCubit.signIn(context);
            } else {
              Toast.show(
                S.of(context).please_fill_all_fields,
                duration: Toast.lengthLong,
                gravity: Toast.bottom,
                backgroundColor: AppColors.blue,
              );
            }
          },
          color: AppColors.grey.withOpacity(0.5),
          radius: 20.sp,
          minWidth: double.infinity,
          child: authCubit.state is LoginLoading
              ? const CircularProgressIndicator().center().padding(0, 10.h)
              : Text(S.of(context).login).padding(0, 14.h),
        );
      },
    );
  }
}
