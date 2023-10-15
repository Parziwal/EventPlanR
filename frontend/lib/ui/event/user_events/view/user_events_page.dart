import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/event_item_card_landscape.dart';
import 'package:event_planr_app/ui/shared/widgets/event_item_card_portrait.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserEventsPage extends StatefulWidget {
  const UserEventsPage({super.key});

  @override
  State<UserEventsPage> createState() => _UserEventsPageState();
}

class _UserEventsPageState extends State<UserEventsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    _tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final breakpoints = context.breakpoints;

    return EventScaffold(
      title: l10n.userEvents,
      mobileActions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_outlined),
        ),
      ],
      tabBar: TabBar(
        controller: _tabController,
        onTap: (int index) {
          setState(() {
            _tabController.animateTo(index);
          });
        },
        tabs: [
          Tab(text: l10n.userEvents_Upcoming),
          Tab(text: l10n.userEvents_Invitation),
          Tab(text: l10n.userEvents_Past),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: breakpoints.isMobile ? 500 : 400,
          crossAxisSpacing: 16,
          mainAxisExtent: breakpoints.isMobile ? 150 : null,
        ),
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          top: 8,
        ),
        itemBuilder: (context, index) {
          return breakpoints.isMobile
              ? EventItemCardLandscape(
            onPressed: () => context.go(
              PagePaths.userEventTickets('Test'),
            ),
            event: Event(
              id: 'asd',
              name: 'Event name',
              venue: 'Venue',
              organizationName: 'Organization name',
              fromDate: DateTime.now(),
              toDate: DateTime.now(),
              coverImage: const NetworkImage(
                'https://images.pexels.com/photos/2747449/pexels-photo-2747449.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
              ),
            ),
          )
              : FittedBox(
            child: EventItemCardPortrait(
              onPressed: () => context.go(
                PagePaths.userEventTickets('Test'),
              ),
              event: Event(
                id: 'asd',
                name: 'Event name',
                venue: 'Venue',
                organizationName: 'Organization name',
                fromDate: DateTime.now(),
                toDate: DateTime.now(),
                coverImage: const NetworkImage(
                  'https://images.pexels.com/photos/2747449/pexels-photo-2747449.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
