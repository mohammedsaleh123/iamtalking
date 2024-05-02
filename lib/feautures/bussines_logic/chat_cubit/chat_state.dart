part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetChatLoading extends ChatState {}

final class GetChatSuccess extends ChatState {}

final class GetChatError extends ChatState {
  final String error;
  GetChatError({required this.error});
}

final class SendMessageLoading extends ChatState {}

final class SendMessageSuccess extends ChatState {}

final class SendMessageError extends ChatState {
  final String error;
  SendMessageError({required this.error});
}

final class ChangeRecordingState extends ChatState {}

final class RecordingState extends ChatState {}

final class UploadProfileImageLoading extends ChatState {}

final class UploadProfileImageSuccess extends ChatState {}

final class UploadProfileImageFailed extends ChatState {
  final String error;
  UploadProfileImageFailed({required this.error});
}

final class ChangePlayOnlineState extends ChatState {}

final class ChangePlayLocalState extends ChatState {}

final class PlayAudioOnlineState extends ChatState {}

final class PlayAudioLocalState extends ChatState {}
