import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/constants/app_strings.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/core/routes/route_strings.dart';
import 'package:iamtalking/feautures/bussines_logic/auth_cubit/auth_cubit.dart';
import 'package:iamtalking/feautures/presentation/auth_view/register/widgets/confirm_password_field.dart';
import 'package:iamtalking/feautures/presentation/auth_view/register/widgets/name_field.dart';
import 'package:iamtalking/feautures/presentation/auth_view/register/widgets/register_button.dart';
import 'package:iamtalking/feautures/presentation/auth_view/widgets/email_field.dart';
import 'package:iamtalking/feautures/presentation/auth_view/widgets/password_field.dart';
import 'package:iamtalking/feautures/presentation/auth_view/widgets/swith_betwen_login_and_register.dart';
import 'package:iamtalking/generated/l10n.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: cubit.registerFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          child: cubit.profileImage == null
                              ? const Icon(
                                  Icons.account_circle,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100.sp),
                                  child: Image.file(
                                    cubit.profileImage!,
                                    fit: BoxFit.fill,
                                    height: 140.sp,
                                    width: 140.sp,
                                  ),
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              cubit.uploadProfileImage(
                                  AppStrings.image, AppStrings.gallery);
                            },
                            child: const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    );
                  },
                ).padding(0, 14.h),
                NameField(
                  nameController: cubit.registerNameController,
                ).padding(0, 14.h),
                EmailField(
                  emailController: cubit.registerEmailController,
                ).padding(0, 14.h),
                PasswordField(
                        passwordController: cubit.registerPasswordController,
                        obsecureText: true)
                    .padding(0, 14.h),
                ConfirmPasswordField(
                        confirmPasswordController:
                            cubit.registerConfirmPasswordController,
                        obsecureText: true)
                    .padding(0, 14.h),
                SwitchBetwenLogInAndRegister(
                  text: S.of(context).login,
                  switchText: S.of(context).already_have_an_account,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(loginViewRoute);
                  },
                ),
                const RegisterButton().padding(0, 14.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
