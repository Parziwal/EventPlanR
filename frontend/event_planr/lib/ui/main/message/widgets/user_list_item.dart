import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: () {
        context.go('/main/message/chat');
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const CircleAvatar(
              foregroundImage:
                  NetworkImage('https://via.placeholder.com/150'),
              radius: 30,
            ),
            const SizedBox(width: 10),
            Text(
              'User name',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
