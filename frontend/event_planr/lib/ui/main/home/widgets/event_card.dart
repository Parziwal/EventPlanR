import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SizedBox(
      width: 200,
      height: 202,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 100,
              child: Image.network(
                'https://placehold.co/600x500.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event name',
                    maxLines: 1,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Chip(
                    label: Text(
                      'Event type',
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const Text('Budapest BME'),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_add_outlined),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}