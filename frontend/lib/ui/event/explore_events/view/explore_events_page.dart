import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/widgets/event_scaffold.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/filter_app_bar.dart';
import 'package:event_planr_app/ui/shared/widgets/event_item_list.dart';
import 'package:flutter/material.dart';

class ExploreEventsPage extends StatelessWidget {
  const ExploreEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EventScaffold(
      title: l10n.exploreEvents,
      appBar: const FilterAppBar(),
      body: const EventItemList(),
    );
  }
}
