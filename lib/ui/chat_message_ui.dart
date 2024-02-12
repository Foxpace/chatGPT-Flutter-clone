import 'package:chat_gpt_client/model/chat_message.dart';
import 'package:flutter/material.dart';

class ChatMessageUi extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageUi({super.key, required this.message});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        if (message.person.isUser) const Spacer(),
        Container(
                color: message.person.isUser
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                    : Colors.black12,
                width: MediaQuery.sizeOf(context).width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(message.text,),
                )),
      ],
    ),
  );
}
