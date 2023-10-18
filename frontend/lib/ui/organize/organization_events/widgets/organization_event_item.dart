import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
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
              const AvatarIcon(altText: 'A'),
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
