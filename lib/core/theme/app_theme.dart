import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/app_bussines_logic/cubit/app_cubit.dart';
import 'package:iamtalking/core/utils/app_colors.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black, foregroundColor: AppColors.white),
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.black,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.black,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.white,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.white),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: whiteTextStyle(16.sp, FontWeight.normal, context),
    ),
    primaryColor: AppColors.deepGrey,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.black,
    ),
    cardColor: AppColors.grey,
    primaryColorLight: AppColors.deebBlue,
  );
}

ThemeData lightTheme(BuildContext context) {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white, foregroundColor: AppColors.black),
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.white,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.white,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.black,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.black),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: whiteTextStyle(16.sp, FontWeight.normal, context),
    ),
    primaryColor: AppColors.grey.withOpacity(0.5),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.white,
    ),
    cardColor: AppColors.deepGrey,
    primaryColorLight: AppColors.white,
  );
}

TextStyle whiteTextStyle(
    double? fontSize, FontWeight? fontWeight, BuildContext context) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: BlocProvider.of<AppBloc>(context).isDark
        ? AppColors.white
        : AppColors.black,
  );
}
