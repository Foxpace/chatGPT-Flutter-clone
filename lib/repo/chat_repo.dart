import 'package:chat_gpt_client/model/chat_message.dart';

abstract class ChatRepo {
  Future<ChatMessage> getResponse(List<ChatMessage> messages);
}