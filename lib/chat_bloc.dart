import 'package:chat_gpt_client/model/chat_message.dart';
import 'package:chat_gpt_client/model/chat_personality.dart';
import 'package:chat_gpt_client/model/chat_state.dart';
import 'package:chat_gpt_client/repo/chat_gpt_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Cubit<ChatState> {
  bool _processing = false;
  final _chatRepo = ChatGptRepo();

  ChatBloc() : super(ChatContent([]));

  Future<void> processMessage(String text) async {
    if (text.isEmpty) {
      return;
    }

    if (_processing) {
      return;
    }

    _processing = true;
    await _processMessages(text);
    _processing = false;
  }

  Future<void> _processMessages(String text) async {

    final messages = switch (state) {
      ChatContent(messages: final messages) => messages,
      ChatError() => <ChatMessage>[]
    };

    messages.add(ChatMessage(text, ChatPersonality.user));
    emit(ChatContent(messages));

    final ChatMessage aiMessage;

    try {
      aiMessage = await _chatRepo.processMessages(messages);
    } catch (e) {
      emit(ChatError(e.toString()));
      return;
    }

    messages.add(aiMessage);
    emit(ChatContent(messages));
  }
}
