import 'package:event_planr/domain/event/event.dart';
import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  const EventItem({required this.event, super.key});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: () => context.go('/main/explore/event-details/${event.id}'),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 2,
                child: Stack(
                  children: [
                    Hero(
                      tag: event.id,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image(
                          image: event.coverImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Text(DateFormat.MMMd().format(event.fromDate)),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event.name,
                        style: theme.textTheme.titleMedium?.copyWith(height: 1),
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
                          Text(event.venue),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.bookmark_add_outlined),
                            visualDensity: VisualDensity.compact,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
