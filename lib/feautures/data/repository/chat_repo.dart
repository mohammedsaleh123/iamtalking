import 'package:iamtalking/core/services/services_locator.dart';
import 'package:iamtalking/feautures/data/models/chat_model.dart';

import '../services/chat_services.dart';

class ChatRepo {
  final ChatServices chatServices = sl<ChatServices>();
  Future<void> sendMessage(String chatId, Map<String, dynamic> data) async {
    await chatServices.sendMessage(chatId, data);
  }

  Stream<List<ChatModel>> getChat(String chatId) {
    return chatServices.getChat(chatId).snapshots().map((event) =>
        event.docs.map((chat) => ChatModel.fromMap(chat.data())).toList());
  }
}
