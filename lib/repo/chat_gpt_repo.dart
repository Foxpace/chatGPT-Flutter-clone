import 'dart:convert';

import 'package:chat_gpt_client/model/chat_personality.dart';
import 'package:chat_gpt_client/repo/chat_gpt_secret.dart';
import 'package:http/http.dart' as http;

import 'package:chat_gpt_client/model/chat_message.dart';

class ChatGptRepo {

  static const endpoint = "https://api.openai.com/v1/chat/completions";
  static const model = "gpt-3.5-turbo";
  static const user = "user";
  static const role = "assistant";
  static const roleDescription = "You are a helpful assistant.";
  static const headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer ${ChatGptSecret.privateKey}",
  };

  final client = http.Client();

  Future<ChatMessage> processMessages(List<ChatMessage> messages) async {
    final body = {
      "model": ChatGptRepo.model,
      "messages": [
        {"role": "system", "content": roleDescription},
        ...messages.map((message) => {
              "role": message.person.isUser ? user : role,
              "content": message.text
            })
      ]
    };

    final bodyJson = jsonEncode(body);
    final response = await client.post(Uri.parse(endpoint), headers: headers, body: bodyJson);

    if (response.statusCode != 200) {
      throw Exception("Status code: ${response.statusCode} with message: ${response.body}");
    }

    final String responseMessage;
    try {
      final responseJson = jsonDecode(response.body);
      responseMessage = responseJson["choices"][0]["message"]["content"];
    } catch (e){
      throw Exception("Failed to parse the response: ${response.body} due to: $e");
    }

    return ChatMessage(responseMessage, ChatPersonality.ai);

  }

}