// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final List<String> chatId;
  final String message;
  final String senderId;
  final String receiverId;
  String? chatImage;
  String? imagePath;
  final String? chatVideo;
  final String? videoPath;
  final String? chatAudio;
  final String? audioPath;
  final Timestamp createdAt;
  final bool isSeen;

  ChatModel(
      {required this.chatId,
      required this.message,
      required this.senderId,
      required this.receiverId,
      this.chatImage,
      this.imagePath,
      this.chatVideo,
      this.videoPath,
      this.chatAudio,
      this.audioPath,
      required this.createdAt,
      required this.isSeen});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'chatImage': chatImage,
      'imagePath': imagePath,
      'chatVideo': chatVideo,
      'videoPath': videoPath,
      'chatAudio': chatAudio,
      'audioPath': audioPath,
      'createdAt': createdAt,
      'isSeen': isSeen,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: List<String>.from(map['chatId']),
      message: map['message'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      chatImage: map['chatImage'] != null ? map['chatImage'] as String : null,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      chatVideo: map['chatVideo'] != null ? map['chatVideo'] as String : null,
      videoPath: map['videoPath'] != null ? map['videoPath'] as String : null,
      chatAudio: map['chatAudio'] != null ? map['chatAudio'] as String : null,
      audioPath: map['audioPath'] != null ? map['audioPath'] as String : null,
      createdAt: map['createdAt'] as Timestamp,
      isSeen: map['isSeen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
