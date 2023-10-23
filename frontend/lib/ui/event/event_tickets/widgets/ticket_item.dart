import 'dart:math';

import 'package:event_planr_app/domain/models/ticket/ticket.dart';
import 'package:event_planr_app/ui/event/event_tickets/cubit/event_tickets_cubit.dart';
import 'package:event_planr_app/ui/event/event_tickets/widgets/quantity_selector.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({required this.ticket, super.key});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final ticketCubit = context.read<EventTicketsCubit>();
    final saleEnded = !(DateTime.now().isBefore(ticket.saleEnds) &&
        DateTime.now().isAfter(ticket.saleStarts));

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: saleEnded ? theme.colorScheme.onTertiary : null,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ticket.name,
                    style: theme.textTheme.titleLarge,
                  ),
                  QuantitySelector(
                    maxCount: min(ticket.count, 10),
                    disabled: saleEnded,
                    ticketAdded: () => ticketCubit.addTicket(ticket),
                    ticketRemoved: () => ticketCubit.removeTicket(ticket),
                  ),
                ],
              ),
              Text(
                '${ticket.price} HUF',
                style: theme.textTheme.titleMedium,
              ),
              Text(
                ticket.description ?? '',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
