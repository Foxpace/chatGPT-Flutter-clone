import 'package:chat_gpt_client/chat_bloc.dart';
import 'package:chat_gpt_client/model/chat_message.dart';
import 'package:chat_gpt_client/ui/chat_message_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatUi extends StatelessWidget {
  final bool isLoading;
  final List<ChatMessage> messages;

  const ChatUi({super.key, required this.messages, required this.isLoading});

  @override
  Widget build(BuildContext context) => Column(children: [
        ChatMessages(
          messages: messages,
        ),
        ChatTextField(isLoading: isLoading)
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
            : ListView.builder(
                itemCount: messages.length,
                reverse: true,
                itemBuilder: (context, index) => ChatMessageUi(
                    message: messages[messages.length - index - 1])),
      );
}

class ChatTextField extends StatelessWidget {
  final bool isLoading;
  final controller = TextEditingController();

  ChatTextField({super.key, required this.isLoading});

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
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : IconButton(
                    onPressed: () => processMessage(context),
                    icon: const Icon(Icons.send))
          ],
        ),
      );

  void processMessage(BuildContext context) {
    // gets message and replaces it with blank
    final text = controller.text;
    controller.text = "";

    BlocProvider.of<ChatBloc>(context).processMessage(text);

    // removes keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
