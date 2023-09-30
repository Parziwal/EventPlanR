import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/ui/shared/widgets/event_item_card_landscape.dart';
import 'package:event_planr_app/ui/shared/widgets/event_item_card_portrait.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class EventItemList extends StatelessWidget {
  const EventItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoints = context.breakpoints;
    return breakpoints.equals(MOBILE) ? _eventListView() : _eventGridView();
  }

  Widget _eventListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
      ),
      itemBuilder: (context, index) {
        return EventItemCardLandscape(
          event: Event(
            id: 'asd',
            name: 'Event name',
            venue: 'Venue',
            organizationName: 'Organization name',
            fromDate: DateTime.now(),
            toDate: DateTime.now(),
            coverImage: const NetworkImage(
                'https://images.pexels.com/photos/2747449/pexels-photo-2747449.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
          ),
        );
      },
    );
  }

  Widget _eventGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        crossAxisSpacing: 16,
      ),
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
        top: 8,
      ),
      itemBuilder: (context, index) {
        return FittedBox(
          child: EventItemCardPortrait(
            event: Event(
              id: 'asd',
              name: 'Event name',
              venue: 'Venue',
              organizationName: 'Organization name',
              fromDate: DateTime.now(),
              toDate: DateTime.now(),
              coverImage: const NetworkImage(
                  'https://images.pexels.com/photos/2747449/pexels-photo-2747449.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
            ),
          ),
        );
      },
    );
  }
}
