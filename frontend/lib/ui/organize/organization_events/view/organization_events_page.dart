import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organization_events/widgets/organization_event_item.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OrganizationEventsPage extends StatefulWidget {
  const OrganizationEventsPage({super.key});

  @override
  State<OrganizationEventsPage> createState() => _OrganizationEventsPageState();
}

class _OrganizationEventsPageState extends State<OrganizationEventsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OrganizeScaffold(
      title: l10n.organizationEvents,
      tabBar: TabBar(
        controller: _tabController,
        onTap: (int index) {
          setState(() {
            _tabController.animateTo(index);
          });
        },
        tabs: [
          Tab(text: l10n.organizationEventsUpcoming),
          Tab(text: l10n.organizationEventsDraft),
          Tab(text: l10n.organizationEventsPast),
        ],
      ),
      body: Center(
        child: MaxWidthBox(
          maxWidth: 1000,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 700,
              mainAxisExtent: 100,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            padding: const EdgeInsets.only(top: 8, left: 32, right: 32),
            itemBuilder: (context, index) {
              return const OrganizationEventItem();
            },
          ),
        ),
      ),
    );
  }
}
