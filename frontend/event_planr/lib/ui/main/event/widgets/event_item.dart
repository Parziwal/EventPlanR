import 'package:event_planr/domain/event/event.dart';
import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  const EventItem({required this.event, required this.child, super.key});

  final Event event;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 2,
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Image(
                          image: event.coverImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name,
                          style:
                              theme.textTheme.titleMedium?.copyWith(height: 1),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Chip(
                          label: Text(
                            event.category.toString().split('.')[1],
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            Text(
                              event.venue,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.bookmark_add_outlined),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          child
        ],
      ),
    );
  }
}
