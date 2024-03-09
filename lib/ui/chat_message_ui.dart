import 'package:chat_gpt_client/model/chat_message.dart';
import 'package:flutter/material.dart';

class ChatMessageUi extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageUi({super.key, required this.message});

  @override
  Widget build(BuildContext context) => Align(
        alignment: message.person.isUser
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .75),
              color: message.person.isUser
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                  : Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectableText(
                  message.text,
                ),
              )),
        ),
      );
}
