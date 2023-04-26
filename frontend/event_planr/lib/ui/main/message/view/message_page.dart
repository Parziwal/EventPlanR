import 'package:event_planr/ui/main/message/message.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined),
          )
        ],
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          onTap: (int index) {
            setState(() {
              _tabController.animateTo(index);
            });
          },
          tabs: const [
            Tab(text: 'Event'),
            Tab(text: 'Direct'),
          ],
        ),
      ),
      body: ListView(
        children: const [
          UserListItem(),
          UserListItem(),
        ],
      ),
    );
  }
}
