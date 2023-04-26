import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event details'),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_add_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://picsum.photos/id/24/400/300.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event name',
                    style: context.theme.textTheme.headlineLarge,
                  ),
                  Text(
                    'Type',
                    style: context.theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(DateFormat.MMMMEEEEd().format(DateTime.now())),
                    subtitle: Text(
                        '${DateFormat.Hm().format(DateTime.now())} - ${DateFormat.Hm().format(DateTime.now())}'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text('Budapest BME'),
                    subtitle: Text('Irinyi József utca 3, Budapest, HU'),
                  ),
                  Text('About', style: context.theme.textTheme.titleLarge),
                  const SizedBox(height: 10),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sapien augue, eleifend at urna non, volutpat consequat urna. Morbi risus ante, ullamcorper ut velit vitae, faucibus porttitor massa. Sed eget volutpat nunc. Maecenas consequat quis risus at hendrerit.',
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
                          'Organization name as dad asdasdasd',
                          style: context.theme.textTheme.titleMedium,
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
                  Text('News', style: context.theme.textTheme.titleLarge),
                  const SizedBox(height: 10),
                  const Divider(),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sapien augue, eleifend at urna non, volutpat consequat urna. Morbi risus ante, ullamcorper ut velit vitae, faucibus porttitor massa. Sed eget volutpat nunc. Maecenas consequat quis risus at hendrerit.',
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
      ),
      bottomSheet: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: FilledButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            textStyle: context.theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
          child: const Text('Buy Ticket'),
        ),
      ),
    );
  }
}
