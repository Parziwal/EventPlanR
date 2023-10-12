import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/widgets/event_scaffold.dart';
import 'package:event_planr_app/ui/event/user_messages/widgets/chat_contact_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/max_width_box.dart';

class UserMessagesPage extends StatefulWidget {
  const UserMessagesPage({super.key});

  @override
  State<UserMessagesPage> createState() => _UserMessagesPageState();
}

class _UserMessagesPageState extends State<UserMessagesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
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

    return EventScaffold(
      title: l10n.userMessages,
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
          Tab(text: l10n.userMessages_Event),
          Tab(text: l10n.userMessages_Direct),
        ],
      ),
      body: Center(
        child: MaxWidthBox(
          maxWidth: 1000,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500,
              mainAxisExtent: 100,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
            itemBuilder: (context, index) {
              return const ChatContactItem();
            },
          ),
        ),
      ),
    );
  }
}
