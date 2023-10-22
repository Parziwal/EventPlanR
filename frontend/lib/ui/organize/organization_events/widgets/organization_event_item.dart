import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/event/organization_event.dart';
import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrganizationEventItem extends StatelessWidget {
  OrganizationEventItem({required this.event}) : super(key: ValueKey(event.id));

  final OrganizationEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: () => context.go(PagePaths.organizationEventDetails(event.id)),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AvatarIcon(
                altText: event.name[0],
                imageUrl: event.coverImageUrl,
              ),
              const SizedBox(width: 32),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    DateFormat.yMMMEd().format(event.fromDate),
                    style: theme.textTheme.titleSmall!
                        .copyWith(color: theme.colorScheme.secondary),
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
