import 'package:event_planr/ui/main/message/message.dart';
import 'package:event_planr/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocBuilder<MessageCubit, MessageState>(
        builder: (context, state) {
          if (state is MessageLoading) {
            return const Loading();
          } else if (state is MessageUserList) {
            return ListView.builder(
              itemBuilder: (context, index) => UserListItem(
                user: state.users[index],
              ),
              itemCount: state.users.length,
            );
          }

          return Container();
        },
      ),
    );
  }
}
