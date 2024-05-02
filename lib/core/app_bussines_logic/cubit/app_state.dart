part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class AppThemeChangedLoading extends AppState {}

final class AppThemeChangedSuccess extends AppState {}

final class AppThemeChangedError extends AppState {
  final String error;
  AppThemeChangedError(this.error);
}

final class AppLanguageChangedLoading extends AppState {}

final class AppLanguageChangedSuccess extends AppState {}

final class AppLanguageChangedError extends AppState {
  final String error;
  AppLanguageChangedError(this.error);
}
