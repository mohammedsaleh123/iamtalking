part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailed extends AuthState {
  final String error;
  LoginFailed(this.error);
}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterFailed extends AuthState {
  final String error;
  RegisterFailed(this.error);
}

final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class LogoutFailed extends AuthState {
  final String error;
  LogoutFailed(this.error);
}

final class LoginWithGoogleLoading extends AuthState {}

final class LoginWithGoogleSuccess extends AuthState {}

final class LoginWithGoogleFailed extends AuthState {
  final String error;
  LoginWithGoogleFailed(this.error);
}

final class UploadProfileImageLoading extends AuthState {}

final class UploadProfileImageSuccess extends AuthState {}

final class UploadProfileImageFailed extends AuthState {
  final String error;
  UploadProfileImageFailed(this.error);
}

final class DeleteProfileImageLoading extends AuthState {}

final class DeleteProfileImageSuccess extends AuthState {}

final class DeleteProfileImageFailed extends AuthState {
  final String error;
  DeleteProfileImageFailed(this.error);
}
