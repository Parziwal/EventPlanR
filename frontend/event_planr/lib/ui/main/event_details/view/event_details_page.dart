import 'package:event_planr/ui/main/event_details/cubit/event_details_cubit.dart';
import 'package:event_planr/ui/main/event_details/view/event_details_view.dart';
import 'package:event_planr/ui/shared/shared.dart';
import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event details'),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_add_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: BlocBuilder<EventDetailsCubit, EventDetailsState>(
        builder: (context, state) {
          if (state.status == EventDetailsStatus.loading) {
            return const Loading();
          } else if (state.status == EventDetailsStatus.success) {
            return EventDetailsView(event: state.event!);
          }
          return Container();
        },
      ),
      bottomSheet: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: FilledButton(
          onPressed: () {
            final eventId = context.read<EventDetailsCubit>().state.event!.id;
            context.go(
              '/main/explore/event-details/$eventId/event-ticket',
            );
          },
          style: ElevatedButton.styleFrom(
            textStyle: context.theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
          child: const Text('Buy Ticket'),
        ),
      ),
    );
  }
}
