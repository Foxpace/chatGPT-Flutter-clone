import 'package:flutter/material.dart';

class ChatErrorUi extends StatelessWidget {
  final String errorMessage;

  const ChatErrorUi({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(errorMessage),
      );
}
