part of 'comment_cubit.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class AddCommentLoading extends CommentState {}

final class AddCommentSuccess extends CommentState {}

final class AddCommentFailed extends CommentState {
  final String error;

  AddCommentFailed(this.error);
}

final class DeleteCommentLoading extends CommentState {}

final class DeleteCommentSuccess extends CommentState {}

final class DeleteCommentFailed extends CommentState {
  final String error;

  DeleteCommentFailed(this.error);
}

final class LikeCommentLoading extends CommentState {}

final class LikeCommentSuccess extends CommentState {}

final class LikeCommentFailed extends CommentState {
  final String error;

  LikeCommentFailed(this.error);
}

final class UnlikeCommentLoading extends CommentState {}

final class UnlikeCommentSuccess extends CommentState {}

final class UnlikeCommentFailed extends CommentState {
  final String error;

  UnlikeCommentFailed(this.error);
}

final class UpdateCommentLoading extends CommentState {}

final class UpdateCommentSuccess extends CommentState {}

final class UpdateCommentFailed extends CommentState {
  final String error;

  UpdateCommentFailed(this.error);
}

final class GetCommentsLoading extends CommentState {}

final class GetCommentsSuccess extends CommentState {}

final class GetCommentsFailed extends CommentState {
  final String error;

  GetCommentsFailed(this.error);
}
