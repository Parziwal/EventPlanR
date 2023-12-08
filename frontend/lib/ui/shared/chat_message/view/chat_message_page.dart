import 'package:event_planr_app/domain/models/chat/create_chat_message.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/shared/chat_message/cubit/chat_message_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:responsive_framework/max_width_box.dart';

class ChatMessagePage extends StatelessWidget {
  const ChatMessagePage({required this.frame, super.key});

  final Widget Function(String? title, Widget child) frame;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;
    final chatId = context.goRouterState.pathParameters['chatId']!;

    return frame(
      context.watch<ChatMessageCubit>().state.chat?.getName(context) ??
          l10n.chatMessage_Chat,
      MaxWidthBox(
        maxWidth: 600,
        child: BlocBuilder<ChatMessageCubit, ChatMessageState>(
          builder: (context, state) {
            if (state.status == ChatMessageStatus.loading) {
              return const LoadingIndicator();
            }

            return Chat(
              showUserNames: true,
              showUserAvatars: true,
              messages: state.messages,
              onSendPressed: (message) =>
                  context.read<ChatMessageCubit>().createMessage(
                        CreateChatMessage(
                          chatId: chatId,
                          content: message.text,
                        ),
                      ),
              user: state.user,
              theme: DefaultChatTheme(
                primaryColor: theme.colorScheme.primary,
                secondaryColor: theme.colorScheme.secondary,
                backgroundColor: theme.colorScheme.background,
                inputBackgroundColor: theme.colorScheme.secondary,
                inputTextColor: theme.colorScheme.onSecondary,
                inputTextCursorColor: theme.colorScheme.onSecondary,
                sentMessageBodyTextStyle: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.onPrimary),
                receivedMessageBodyTextStyle: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.onSecondary),
                userAvatarNameColors: [theme.colorScheme.inversePrimary],
              ),
              l10n: ChatL10nEn(
                inputPlaceholder: l10n.chatMessage_Message,
              ),
            );
          },
        ),
      ),
    );
  }
}
