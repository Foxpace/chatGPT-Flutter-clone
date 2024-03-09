import 'package:chat_gpt_client/chat_bloc.dart';
import 'package:chat_gpt_client/model/chat_state.dart';
import 'package:chat_gpt_client/ui/chat_error.dart';
import 'package:chat_gpt_client/ui/chat_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) => switch (state) {
                    ChatContent(messages: final messages) =>
                      ChatUi(messages: messages, isLoading: false),
                    ChatLoading(messages: final messages) =>
                      ChatUi(messages: messages, isLoading: true),
                    ChatError(errorMessage: final errorMessage) =>
                      ChatErrorUi(errorMessage: errorMessage),
                  }),
        ),
      );
}
