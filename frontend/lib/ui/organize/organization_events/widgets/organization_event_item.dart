import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class OrganizationEventItem extends StatelessWidget {
  const OrganizationEventItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const AspectRatio(
                aspectRatio: 1,
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1780&q=80'),
                ),
              ),
              const SizedBox(width: 32),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event name',
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '2023.09.01',
                    style: theme.textTheme.titleSmall!
                        .copyWith(color: theme.colorScheme.secondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '100/0',
                    style: theme.textTheme.titleSmall!
                        .copyWith(color: theme.colorScheme.tertiary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
