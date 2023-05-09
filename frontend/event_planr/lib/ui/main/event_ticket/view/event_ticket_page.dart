import 'package:event_planr/ui/main/event_ticket/cubit/event_ticket_cubit.dart';
import 'package:event_planr/ui/main/event_ticket/widgets/ticket_item.dart';
import 'package:event_planr/ui/shared/shared.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventTicketPage extends StatelessWidget {
  const EventTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
      ),
      body: BlocConsumer<EventTicketCubit, EventTicketState>(
        listener: (context, state) {
          if (state.status == EventTicketStatus.checkout) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    'Order was successfull succefully processed',
                  ),
                ),
              );
            context.go('/main/event/user-ticket/${context.read<EventTicketCubit>().eventId}');
          }
        },
        builder: (context, state) {
          if (state.status == EventTicketStatus.loading) {
            return const Loading();
          } else if (state.status == EventTicketStatus.success) {
            return ListView.builder(
              itemCount: state.eventTickets.length,
              itemBuilder: (context, index) =>
                  TicketItem(ticket: state.eventTickets[index]),
            );
          }

          return Container();
        },
      ),
      bottomSheet: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${context.watch<EventTicketCubit>().state.totalPrice} HUF',
                    style: context.theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.read<EventTicketCubit>().buyTickets(),
              style: ElevatedButton.styleFrom(
                textStyle: context.theme.textTheme.titleMedium,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
