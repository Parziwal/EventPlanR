import 'package:event_planr_app/ui/event/explore_events/cubit/explore_events_cubit.dart';
import 'package:event_planr_app/ui/event/explore_events/view/explore_events_page.dart';
import 'package:event_planr_app/ui/event/explore_events/view/explore_organizations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventView = context.watch<ExploreEventsCubit>().state.eventView;

    return eventView
        ? const ExploreEventsPage()
        : const ExploreOrganizationsPage();
  }
}
