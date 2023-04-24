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

    return SizedBox(
      height: 150,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Image(
                          image: event.coverImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child:
                              Text(DateFormat.MMMd().format(event.startDate)),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.name,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(height: 1),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Chip(
                            label: Text(
                              event.category,
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
      ),
    );
  }
}