import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/app_strings.dart';

class ChatServices {
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
}
