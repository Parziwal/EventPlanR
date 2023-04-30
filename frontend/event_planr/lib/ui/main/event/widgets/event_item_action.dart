import 'package:event_planr/domain/event/event.dart';
import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';

class EventItemAction extends StatelessWidget {
  const EventItemAction({required this.tab, super.key});

  final UserEventType tab;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    switch (tab) {
      case UserEventType.upcoming:
        return ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.primaryContainer,
            textStyle: theme.textTheme.titleMedium,
          ),
          child: const Text('View ticket'),
        );
      case UserEventType.invite:
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  textStyle: theme.textTheme.titleMedium,
                ),
                child: const Text('Accept'),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: theme.colorScheme.secondary,
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  textStyle: theme.textTheme.titleMedium,
                ),
                child: const Text('Reject'),
              ),
            ),
          ],
        );
      case UserEventType.past:
        return ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.primaryContainer,
            textStyle: theme.textTheme.titleMedium,
          ),
          child: const Text('See reviews'),
        );
    }
  }
}
