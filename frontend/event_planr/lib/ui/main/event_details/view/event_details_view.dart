import 'package:event_planr/domain/event/event.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({required this.event, super.key});

  final EventDetails event;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: event.id,
            child: Image(
              image: event.coverImageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: theme.textTheme.headlineLarge,
                ),
                Text(
                  event.category.toString().split('.')[1],
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text(DateFormat.MMMMEEEEd().format(event.fromDate)),
                  subtitle: Text(
                    '''${DateFormat.Hm().format(event.fromDate)} - ${DateFormat.Hm().format(event.toDate)}''',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(event.address.venue),
                  subtitle: Text(event.address.addressLine),
                ),
                Text('About', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                Text(
                  event.description ?? '',
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const CircleAvatar(
                      foregroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                      radius: 30,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Organization name',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Follow'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('News', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                const Divider(),
                const Text(
                  '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sapien augue, eleifend at urna non, volutpat consequat urna. Morbi risus ante, ullamcorper ut velit vitae, faucibus porttitor massa. Sed eget volutpat nunc. Maecenas consequat quis risus at hendrerit.''',
                  textAlign: TextAlign.justify,
                ),
                Text(
                  DateFormat.MMMMEEEEd().format(DateTime.now()),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const Divider(),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
