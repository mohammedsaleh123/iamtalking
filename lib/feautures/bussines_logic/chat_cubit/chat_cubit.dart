import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iamtalking/feautures/data/models/chat_model.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/helper/picke_file_helper.dart';
import '../../../core/helper/upload_to_storage_helper.dart';
import '../../../core/services/services_locator.dart';
import '../../data/repository/chat_repo.dart';

part 'chat_state.dart';

class ChatBloc extends Cubit<ChatState> {
  ChatBloc() : super(ChatInitial());

  final ChatRepo chatRepo = sl<ChatRepo>();
  UploadToStorageHelper uploadToStorageHelper = sl<UploadToStorageHelper>();
  PickeFileHelper pickeFileServices = sl<PickeFileHelper>();
  TextEditingController messageController = TextEditingController();
  VideoPlayerController? videoController;
  AudioPlayer audioPlayer = AudioPlayer();
  File? chatImageFile;
  File? chatVideoFile;
  File? chatAudioFile;
  String? chatImage;
  String? chatVideo;
  String? chatAudio;
  bool isRecording = false;
  bool isVideo = false;
  bool isOnlinePlay = false;
  bool isLocalPlay = false;
  int? selectedIndex;

  Stream<List<ChatModel>> getChat(String receiverId) {
    //emit(GetChatLoading());
    try {
      List<String> chatRoom = [
        FirebaseAuth.instance.currentUser!.uid,
        receiverId
      ];
      chatRoom.sort();
      String chatRoomId = chatRoom.join('-');
      chatRepo.getChat(chatRoomId);
      //emit(GetChatSuccess());
      return chatRepo.getChat(chatRoomId);
    } catch (e) {
      //emit(GetChatError(error: e.toString()));
      rethrow;
    }
  }

  Future<void> sendMessage(
    String receiverId,
  ) async {
    emit(SendMessageLoading());
    isRecording = false;
    final uuid = const Uuid().v4();
    if (chatImageFile != null) {
      chatImage = await uploadToStorageHelper.uploadFile(
        path: AppStrings.chatsCollection,
        file: chatImageFile!,
        uuid: uuid,
      );
    } else if (chatVideoFile != null) {
      chatVideo = await uploadToStorageHelper.uploadFile(
        path: AppStrings.chatsCollection,
        file: chatVideoFile!,
        uuid: uuid,
      );
    } else if (chatAudioFile != null) {
      chatAudio = await uploadToStorageHelper.uploadFile(
        path: AppStrings.chatsCollection,
        file: chatAudioFile!,
        uuid: uuid,
      );
    }
    List<String> chatRoom = [
      FirebaseAuth.instance.currentUser!.uid,
      receiverId
    ];
    chatRoom.sort();
    String chatRoomId = chatRoom.join('-');
    final data = ChatModel(
            chatId: chatRoom,
            message: messageController.text,
            senderId: FirebaseAuth.instance.currentUser!.uid,
            receiverId: receiverId,
            chatImage: chatImage,
            imagePath: chatImage == null
                ? null
                : '${AppStrings.chatsCollection}/$uuid',
            chatVideo: chatVideo,
            videoPath: chatVideo == null
                ? null
                : '${AppStrings.chatsCollection}/$uuid',
            chatAudio: chatAudio,
            audioPath: chatAudio == null
                ? null
                : '${AppStrings.chatsCollection}/$uuid',
            createdAt: firebase.Timestamp.now(),
            isSeen: false)
        .toMap();
    chatRepo.sendMessage(chatRoomId, data).then(
      (value) {
        emit(SendMessageSuccess());
        messageController.clear();
        chatImage = null;
        chatVideo = null;
        chatAudio = null;
        chatImageFile = null;
        chatVideoFile = null;
        chatAudioFile = null;
      },
    ).catchError(
      (e) {
        emit(SendMessageError(error: e.toString()));
      },
    );
  }

  File? uploadPostImage(String type, String source) {
    File? file;
    emit(UploadProfileImageLoading());
    try {
      pickeFileServices.pickFile(type, source).then((value) {
        chatImageFile = File(value!.path);
        file = chatImageFile;
        if (type == AppStrings.video) {
          isVideo = true;
          videoController = VideoPlayerController.file(chatVideoFile!)
            ..initialize();
          file = chatVideoFile;
          videoController!.play();
        }
        emit(UploadProfileImageSuccess());
      });
      return file;
    } catch (e) {
      emit(UploadProfileImageFailed(error: e.toString()));
    }
    return null;
  }

  void changeIsRecording() {
    isRecording = !isRecording;
    if (isRecording == false) {
      chatAudioFile = null;
      isLocalPlay = false;
    }
    emit(ChangeRecordingState());
  }

  void sendRequestAudioFunction(File file, String path) {
    chatAudioFile = file;
    chatAudio = path;
    emit(RecordingState());
  }

  void changePlayOnlineState() {
    isOnlinePlay = !isOnlinePlay;
    emit(ChangePlayOnlineState());
  }

  void changePlayLocalState() {
    isLocalPlay = !isLocalPlay;
    emit(ChangePlayLocalState());
  }

  void playAudioOnline(String url, int index) async {
    selectedIndex = index;
    emit(PlayAudioOnlineState());
    if (isOnlinePlay) {
      await audioPlayer.play(UrlSource(url));
    } else {
      audioPlayer.pause();
    }
  }

  void playAudioLocal() {
    if (isLocalPlay) {
      audioPlayer.play(UrlSource(chatAudioFile!.path));
    } else {
      audioPlayer.pause();
    }
    emit(PlayAudioLocalState());
  }
}
