import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/datetime_format.dart';
import 'package:flutter/material.dart';

class EventItemCardPortrait extends StatelessWidget {
  const EventItemCardPortrait({required this.event, super.key});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SizedBox(
      width: 400,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                      image: event.coverImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: IconButton.filled(
                      icon: const Icon(Icons.bookmark_add_outlined),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      event.name,
                      style: theme.textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatEventDateTimeRange(
                        event.fromDate,
                        event.toDate,
                      ),
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.group,
                              size: theme.textTheme.bodyLarge!.fontSize,
                              color: theme.colorScheme.secondary,
                            ),
                            alignment: PlaceholderAlignment.middle,
                          ),
                          const WidgetSpan(
                            child: SizedBox(width: 10),
                          ),
                          TextSpan(text: event.organizationName),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.location_on_outlined,
                              size: theme.textTheme.bodyLarge!.fontSize,
                              color: theme.colorScheme.secondary,
                            ),
                            alignment: PlaceholderAlignment.middle,
                          ),
                          const WidgetSpan(
                            child: SizedBox(width: 10),
                          ),
                          TextSpan(text: event.venue),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
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
}
