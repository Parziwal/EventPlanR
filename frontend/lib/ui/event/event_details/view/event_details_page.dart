import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/widgets/event_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return EventScaffold(
      title: l10n.eventDetails,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://images.pexels.com/photos/2747449/pexels-photo-2747449.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
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
                    style: theme.textTheme.headlineLarge,
                  ),
                  Text(
                    'category',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(DateFormat.MMMMEEEEd().format(DateTime.now())),
                    subtitle: Text(
                      '''${DateFormat.Hm().format(DateTime.now())} - ${DateFormat.Hm().format(DateTime.now())}''',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text('Venue'),
                    subtitle: Text('Address line'),
                  ),
                  Text('About', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Text(
                    'Description' ?? '',
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
      ),
    );
  }
}
