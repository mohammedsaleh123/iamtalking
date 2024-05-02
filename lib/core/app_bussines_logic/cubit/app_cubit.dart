import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iamtalking/core/constants/app_strings.dart';

part 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc() : super(AppInitial());
  bool isDark = true;
  String language = AppStrings.en;
  void changeLanguage() {
    emit(AppLanguageChangedLoading());
    try {
      if (language == AppStrings.en) {
        language = AppStrings.ar;
      } else {
        language = AppStrings.en;
      }
      emit(AppLanguageChangedSuccess());
    } on Exception catch (e) {
      emit(AppLanguageChangedError(e.toString()));
      debugPrint(e.toString());
    }
  }

  void changeTheme() {
    emit(AppThemeChangedLoading());
    try {
      isDark = !isDark;
      emit(AppThemeChangedSuccess());
    } on Exception catch (e) {
      emit(AppThemeChangedError(e.toString()));
      debugPrint(e.toString());
    }
  }
}
