import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/event/event_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/event/event_details/cubit/event_details_cubit.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:event_planr_app/ui/shared/widgets/image_wrapper.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/ui/shared/widgets/static_map.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/datetime_format.dart';
import 'package:event_planr_app/utils/domain_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/max_width_box.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final goRouterState = context.goRouterState;

    return EventScaffold(
      title: l10n.eventDetails,
      mobileActions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
      ],
      mobileBottomSheet: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: FilledButton(
          onPressed: () => context.go(
            PagePaths.eventTickets(goRouterState.pathParameters['eventId']!),
          ),
          style: FilledButton.styleFrom(
            textStyle: context.theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
          child: Text(l10n.eventDetails_BuyTicket),
        ),
      ),
      body: BlocConsumer<EventDetailsCubit, EventDetailsState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == EventDetailsStatus.loading) {
            return const LoadingIndicator();
          } else if (state.eventDetails != null) {
            return _mainContent(context, state.eventDetails!);
          }

          return Container();
        },
      ),
    );
  }

  Widget _mainContent(BuildContext context, EventDetails eventDetails) {
    return SingleChildScrollView(
      child: MaxWidthBox(
        maxWidth: 800,
        child: Column(
          children: [
            ImageWrapper(imageUrl: eventDetails.coverImageUrl),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleBar(context, eventDetails),
                  const SizedBox(height: 16),
                  ..._timeAndPlace(context, eventDetails),
                  const SizedBox(height: 16),
                  ..._aboutEvent(context, eventDetails),
                  const SizedBox(height: 32),
                  _organization(context, eventDetails),
                  const SizedBox(height: 32),
                  ..._news(context, eventDetails),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    EventDetailsState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == EventDetailsStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.errorCode!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    }
  }

  Widget _titleBar(BuildContext context, EventDetails eventDetails) {
    final l10n = context.l10n;
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
                eventDetails.name,
                style: theme.textTheme.headlineLarge,
              ),
              Text(
                l10n.translateEnums(eventDetails.category.name),
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
        ),
        if (breakpoints.largerThan(MOBILE)) ...[
          FilledButton(
            onPressed: () => context.go(
              PagePaths.eventTickets(
                eventDetails.id,
              ),
            ),
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.symmetric(
                horizontal: 64,
                vertical: 16,
              ),
            ),
            child: Text(l10n.eventDetails_BuyTicket),
          ),
        ],
      ],
    );
  }

  List<Widget> _timeAndPlace(BuildContext context, EventDetails eventDetails) {
    return [
      ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text(
          formatEventDetailsDateRange(
            eventDetails.fromDate,
            eventDetails.toDate,
          ),
        ),
        subtitle: Text(
          formatEventDetailsTimeRange(
            eventDetails.fromDate,
            eventDetails.toDate,
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.location_on_outlined),
        title: Text(eventDetails.venue),
        subtitle: Text(eventDetails.address.formatToString()),
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 300,
        child: StaticMap(location: eventDetails.coordinates),
      ),
    ];
  }

  List<Widget> _aboutEvent(BuildContext context, EventDetails eventDetails) {
    final l10n = context.l10n;
    final theme = context.theme;

    return [
      Text(l10n.eventDetails_About, style: theme.textTheme.titleLarge),
      const SizedBox(height: 8),
      Text(
        eventDetails.description ?? '-',
        textAlign: TextAlign.justify,
      ),
    ];
  }

  Widget _organization(BuildContext context, EventDetails eventDetails) {
    final theme = context.theme;

    return InkWell(
      onTap: () => context.go(
        PagePaths.eventOrganization(
          eventDetails.id,
          eventDetails.organization.id,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            child: AvatarIcon(
              altText: eventDetails.organization.name[0],
              imageUrl: eventDetails.coverImageUrl,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              eventDetails.organization.name,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _news(BuildContext context, EventDetails eventDetails) {
    final l10n = context.l10n;
    final theme = context.theme;

    return [
      Text(l10n.eventDetails_News, style: theme.textTheme.titleLarge),
      const SizedBox(height: 8),
      const Divider(),
      if (eventDetails.latestNews != null) ...[
        Text(
          eventDetails.latestNews!.title,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          eventDetails.latestNews!.text,
          textAlign: TextAlign.justify,
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        Text(
          DateFormat.MMMMEEEEd().format(eventDetails.latestNews!.lastModified),
          style: theme.textTheme.labelMedium,
        ),
        const Divider(),
        Center(
          child: FilledButton(
            onPressed: () => context.go(PagePaths.eventNews(eventDetails.id)),
            child: Text(l10n.eventDetails_MoreNews),
          ),
        ),
      ],
      if (eventDetails.latestNews == null)
        Text(l10n.eventDetails_NoNewsFound, style: theme.textTheme.titleMedium),
    ];
  }
}
