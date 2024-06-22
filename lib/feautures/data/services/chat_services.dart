import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constants/app_strings.dart';

class ChatServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Query<Map<String, dynamic>> getChat(String chatId) {
    final snapshot = firestore
        .collection(AppStrings.chatsCollection)
        .doc(chatId)
        .collection(AppStrings.messagesCollection)
        .orderBy('createdAt', descending: false);
    return snapshot;
  }

  Future<bool> sendMessage(String chatId, Map<String, dynamic> data) async {
    try {
      await firestore
          .collection(AppStrings.chatsCollection)
          .doc(chatId)
          .collection(AppStrings.messagesCollection)
          .add(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteChat(String chatId) async {
    try {
      await firestore
          .collection(AppStrings.chatsCollection)
          .doc(chatId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteMessage(String chatId, String messageId) async {
    try {
      await firestore
          .collection(AppStrings.chatsCollection)
          .doc(chatId)
          .collection(AppStrings.messagesCollection)
          .doc(messageId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateMessage(
      String chatId, String messageId, Map<String, dynamic> data) async {
    try {
      await firestore
          .collection(AppStrings.chatsCollection)
          .doc(chatId)
          .collection(AppStrings.messagesCollection)
          .doc(messageId)
          .update(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
