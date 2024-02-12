import 'package:chat_gpt_client/model/chat_message.dart';

sealed class ChatState {}

class ChatContent extends ChatState {

  final List<ChatMessage> messages;

  ChatContent(this.messages);

}

class ChatError extends ChatState {

  final String errorMessage;

  ChatError(this.errorMessage);

}