import 'package:event_planr/domain/event/event.dart';
import 'package:event_planr/ui/main/event/event.dart';
import 'package:event_planr/ui/main/event/widgets/event_item_action.dart';
import 'package:event_planr/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    _tabController.addListener(() {
      context
          .read<EventCubit>()
          .listMyEvents(type: UserEventType.values[_tabController.index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
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
            Tab(text: 'Upcoming'),
            Tab(text: 'Invite'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Loading();
          } else if (state is EventEventList) {
            return ListView.builder(
              itemBuilder: (context, index) => EventItem(
                event: state.events[index],
                child: EventItemAction(
                  tab: UserEventType.values[_tabController.index],
                ),
              ),
              itemCount: state.events.length,
            );
          }

          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
