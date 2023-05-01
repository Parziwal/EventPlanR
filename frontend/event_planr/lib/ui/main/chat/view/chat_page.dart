import 'dart:convert';
import 'dart:math';

import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          elevation: 2,
        ),
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          theme: DefaultChatTheme(
            primaryColor: context.theme.colorScheme.primary,
            secondaryColor: context.theme.colorScheme.secondary,
            backgroundColor: context.theme.colorScheme.background,
            inputBackgroundColor: context.theme.colorScheme.secondary,
            inputTextColor: context.theme.colorScheme.onSecondary,
            inputTextCursorColor: context.theme.colorScheme.onSecondary,
            sentMessageBodyTextStyle: context.theme.textTheme.titleMedium!
                .copyWith(color: context.theme.colorScheme.onPrimary),
          ),
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  String _randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
