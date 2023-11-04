import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/chat/chat.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/user_chats/cubit/user_chats_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatContactItem extends StatelessWidget {
  const ChatContactItem({required this.chat, super.key});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: () {
        context.read<UserChatsCubit>().setSelectedChat(chat);
        context.go(PagePaths.userChatMessage(chat.id));
      },
      child: Card(
        elevation: 4,
        color: chat.haveUnreadMessage ? theme.colorScheme.inversePrimary : null,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: AvatarIcon(
                  altText: chat.getMonogram(context),
                  imageUrl: chat.profileImageUrl,
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chat.getName(context),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: chat.haveUnreadMessage
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _formatChatDateTime(chat.lastMessageDate, context),
                      style: theme.textTheme.titleSmall!
                          .copyWith(color: theme.colorScheme.secondary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatChatDateTime(DateTime dateTime, BuildContext context) {
    final l10n = context.l10n;

    final timeNow = DateTime.now();
    if (dateTime.difference(timeNow) < const Duration(days: 1)) {
      final hours = dateTime.difference(timeNow).inHours;
      if (hours == 0) {
        return l10n.userChats_Now;
      }
      return l10n.userChats_HourAge(hours.toString());
    }

    return '${DateFormat.yMd().format(dateTime)}, '
        '${DateFormat.jm().format(dateTime)}';
  }
}
