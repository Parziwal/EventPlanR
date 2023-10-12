import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/widgets/event_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/event_item_list.dart';
import 'package:flutter/material.dart';

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
      body: const EventItemList(),
    );
  }
}
