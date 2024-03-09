import 'package:chat_gpt_client/model/chat_message.dart';
import 'package:chat_gpt_client/model/chat_personality.dart';
import 'package:chat_gpt_client/model/chat_state.dart';
import 'package:chat_gpt_client/repo/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Cubit<ChatState> {

  final ChatRepo _chatRepo;

  ChatBloc(this._chatRepo) : super(ChatContent([]));

  Future<void> processMessage(String newMessage) async {

    final isLoading = switch (state) {
      ChatLoading() => true,
      ChatState() => false
    };

    if (isLoading || newMessage.isEmpty) {
      return;
    }

    final messages = switch (state) {
      ChatContent(messages: final messages) => messages,
      ChatState() => <ChatMessage>[]
    };

    messages.add(ChatMessage(newMessage, ChatPersonality.user));

    emit(ChatLoading(messages));
    return _processMessages(messages, newMessage);
  }

  Future<void> _processMessages(List<ChatMessage> messages, String newMessage) async {

    final ChatMessage aiMessage;

    try {
      aiMessage = await _chatRepo.getResponse(messages);
    } catch (e) {
      emit(ChatError(e.toString()));
      return;
    }

    messages.add(aiMessage);
    emit(ChatContent(messages));
  }
}
