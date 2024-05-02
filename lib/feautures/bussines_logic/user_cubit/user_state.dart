part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class GetUserLoading extends UserState {}

final class GetUserSuccess extends UserState {}

final class GetUserFailed extends UserState {
  final String error;
  GetUserFailed(this.error);
}

final class GetAllUsersLoading extends UserState {}

final class GetAllUsersSuccess extends UserState {}

final class GetAllUsersFailed extends UserState {
  final String error;
  GetAllUsersFailed(this.error);
}

final class GetCurrentUserLoading extends UserState {}

final class GetCurrentUserSuccess extends UserState {}

final class GetCurrentUserFailed extends UserState {
  final String error;
  GetCurrentUserFailed(this.error);
}

final class UpdateUserLoading extends UserState {}

final class UpdateUserSuccess extends UserState {}

final class UpdateUserFailed extends UserState {
  final String error;
  UpdateUserFailed(this.error);
}

final class DeleteUserLoading extends UserState {}

final class DeleteUserSuccess extends UserState {}

final class DeleteUserFailed extends UserState {
  final String error;
  DeleteUserFailed(this.error);
}

final class FollowUserLoading extends UserState {}

final class FollowUserSuccess extends UserState {}

final class FollowUserFailed extends UserState {
  final String error;
  FollowUserFailed(this.error);
}

final class UnfollowUserLoading extends UserState {}

final class UnfollowUserSuccess extends UserState {}

final class UnfollowUserFailed extends UserState {
  final String error;
  UnfollowUserFailed(this.error);
}
