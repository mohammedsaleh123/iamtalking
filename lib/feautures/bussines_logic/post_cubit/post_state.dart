part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class AddPostLoading extends PostState {}

final class AddPostSuccess extends PostState {}

final class AddPostFailed extends PostState {
  final String error;

  AddPostFailed(this.error);
}

final class UpdatePostLoading extends PostState {}

final class UpdatePostSuccess extends PostState {}

final class UpdatePostFailed extends PostState {
  final String error;

  UpdatePostFailed(this.error);
}

final class DeletePostLoading extends PostState {}

final class DeletePostSuccess extends PostState {}

final class DeletePostFailed extends PostState {
  final String error;

  DeletePostFailed(this.error);
}

final class LikePostLoading extends PostState {}

final class LikePostSuccess extends PostState {}

final class LikePostFailed extends PostState {
  final String error;

  LikePostFailed(this.error);
}

final class UnlikePostLoading extends PostState {}

final class UnlikePostSuccess extends PostState {}

final class UnlikePostFailed extends PostState {
  final String error;

  UnlikePostFailed(this.error);
}

final class GetAllPostsLoading extends PostState {}

final class GetAllPostsSuccess extends PostState {}

final class GetAllPostsFailed extends PostState {
  final String error;

  GetAllPostsFailed(this.error);
}

final class UploadProfileImageLoading extends PostState {}

final class UploadProfileImageSuccess extends PostState {}

final class UploadProfileImageFailed extends PostState {
  final String error;

  UploadProfileImageFailed(this.error);
}

final class PlayVideoLoading extends PostState {}

final class PlayVideoSuccess extends PostState {}

final class PlayVideoFailed extends PostState {
  final String error;

  PlayVideoFailed(this.error);
}

final class PathPostToEditViewLoading extends PostState {}

final class PathPostToEditViewSuccess extends PostState {}

final class PathPostToEditViewFailed extends PostState {
  final String error;

  PathPostToEditViewFailed(this.error);
}

final class SavePostLoading extends PostState {}

final class SavePostSuccess extends PostState {}

final class SavePostFailed extends PostState {
  final String error;

  SavePostFailed(this.error);
}

final class UnSavePostLoading extends PostState {}

final class UnSavePostSuccess extends PostState {}

final class UnSavePostFailed extends PostState {
  final String error;

  UnSavePostFailed(this.error);
}

final class ClearPostField extends PostState {}
