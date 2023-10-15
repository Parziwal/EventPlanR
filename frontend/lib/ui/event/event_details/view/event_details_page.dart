import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:event_planr_app/ui/shared/widgets/image_wrapper.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/datetime_format.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/max_width_box.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final breakpoints = context.breakpoints;

    return EventScaffold(
      title: l10n.eventDetails,
      mobileActions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
      ],
      mobileBottomSheet: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: FilledButton(
          onPressed: () => context.go(PagePaths.eventTickets('Test')),
          style: FilledButton.styleFrom(
            textStyle: context.theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
          child: const Text('Buy Ticket'),
        ),
      ),
      body: SingleChildScrollView(
        child: MaxWidthBox(
          maxWidth: 800,
          child: Column(
            children: [
              const ImageWrapper(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleBar(context),
                    const SizedBox(height: 16),
                    ..._timeAndPlace(context),
                    const SizedBox(height: 16),
                    ..._aboutEvent(context),
                    const SizedBox(height: 32),
                    _organization(context),
                    const SizedBox(height: 32),
                    ..._news(context),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleBar(BuildContext context) {
    final theme = context.theme;
    final breakpoints = context.breakpoints;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
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
            ],
          ),
        ),
        if (breakpoints.largerThan(MOBILE)) ...[
          FilledButton(
            onPressed: () => context.go(PagePaths.eventTickets('Test')),
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.symmetric(
                horizontal: 64,
                vertical: 16,
              ),
            ),
            child: const Text('Buy Ticket'),
          ),
          const SizedBox(width: 16),
          IconButton.filled(
            onPressed: () {},
            icon: const Icon(Icons.bookmark),
          ),
        ],
      ],
    );
  }

  List<Widget> _timeAndPlace(BuildContext context) {
    return [
      ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text(
          formatEventDetailsDate(DateTime.now(), DateTime.now()),
        ),
        subtitle: Text(
          formatEventDetailsTime(DateTime.now(), DateTime.now()),
        ),
      ),
      const ListTile(
        leading: Icon(Icons.location_on_outlined),
        title: Text('Venue'),
        subtitle: Text('Address line'),
      ),
    ];
  }

  List<Widget> _aboutEvent(BuildContext context) {
    final theme = context.theme;

    return [
      Text('About', style: theme.textTheme.titleLarge),
      const SizedBox(height: 8),
      const Text(
        'Description',
        textAlign: TextAlign.justify,
      ),
    ];
  }

  Widget _organization(BuildContext context) {
    final theme = context.theme;

    return Row(
      children: [
        const SizedBox(
          height: 80,
          child: AvatarIcon(altText: 'A'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'Organization name',
            style: theme.textTheme.titleMedium,
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Follow'),
        ),
      ],
    );
  }

  List<Widget> _news(BuildContext context) {
    final theme = context.theme;

    return [
      Text('News', style: theme.textTheme.titleLarge),
      const SizedBox(height: 8),
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
      Center(
        child: FilledButton(
          onPressed: () {},
          child: const Text('More news'),
        ),
      ),
    ];
  }
}
