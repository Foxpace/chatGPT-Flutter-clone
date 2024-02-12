import 'package:chat_gpt_client/chat_bloc.dart';
import 'package:chat_gpt_client/model/chat_message.dart';
import 'package:chat_gpt_client/ui/chat_message_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatUi extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatUi({super.key, required this.messages});

  @override
  Widget build(BuildContext context) => Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ChatMessages(
          messages: messages,
        ),
        ChatTextField()
      ]);
}

class ChatMessages extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatMessages({super.key, required this.messages});

  @override
  Widget build(BuildContext context) => Expanded(
    child: messages.isEmpty
        ? const Center(
            child: Text("Start writing something!"),
          )
        : SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: messages
                    .map((message) => ChatMessageUi(
                          message: message,
                        ))
                    .toList(),
              ),
          ),
        ),
  );
}

class ChatTextField extends StatelessWidget {
  final controller = TextEditingController();

  ChatTextField({super.key});

  @override
  Widget build(BuildContext context) => Container(
    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
    height: 80,
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.75,
              child: TextField(
                controller: controller,
                onSubmitted: (_) => processMessage(context),
                textInputAction: TextInputAction.send,
                decoration: const InputDecoration(
                  hintText: 'Enter your question',
                ),
              ),
            ),
            IconButton(
                onPressed: () => processMessage(context),
                icon: const Icon(Icons.send))
          ],
        ),
  );

  void processMessage(BuildContext context) {
    if (!context.mounted) {
      return;
    }

    final text = controller.text;
    controller.text = "";

    BlocProvider.of<ChatBloc>(context).processMessage(text);
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
