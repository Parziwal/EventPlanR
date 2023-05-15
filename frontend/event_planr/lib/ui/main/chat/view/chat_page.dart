import 'package:event_planr/ui/main/chat/cubit/chat_cubit.dart';
import 'package:event_planr/ui/shared/shared.dart';
import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          elevation: 2,
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state.status == ChatStatus.loading) {
              return const Loading();
            }

            return chat.Chat(
              messages: state.messages,
              onSendPressed: context.read<ChatCubit>().addMessage,
              user: state.user,
              theme: chat.DefaultChatTheme(
                primaryColor: context.theme.colorScheme.primary,
                secondaryColor: context.theme.colorScheme.secondary,
                backgroundColor: context.theme.colorScheme.background,
                inputBackgroundColor: context.theme.colorScheme.secondary,
                inputTextColor: context.theme.colorScheme.onSecondary,
                inputTextCursorColor: context.theme.colorScheme.onSecondary,
                sentMessageBodyTextStyle: context.theme.textTheme.titleMedium!
                    .copyWith(color: context.theme.colorScheme.onPrimary),
              ),
            );
          },
        ),
      );
}
