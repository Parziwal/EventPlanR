import 'dart:math';

import 'package:event_planr_app/domain/models/ticket/ticket.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
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
    final l10n = context.l10n;
    final theme = context.theme;
    final ticketCubit = context.read<EventTicketsCubit>();
    final timeLeft = ticket.saleEnds.difference(DateTime.now()).inHours;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      ticket.name,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  QuantitySelector(
                    maxCount: min(ticket.remainingCount, 10),
                    ticketAdded: () => ticketCubit.addTicket(ticket),
                    ticketRemoved: () => ticketCubit.removeTicket(ticket),
                  ),
                ],
              ),
              Text(
                '${ticket.price} ${l10n.translateEnums(ticket.currency.name)}',
                style: theme.textTheme.titleMedium,
              ),
              Text(
                ticket.description ?? '',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              if (timeLeft <= 24)
                Text(l10n.eventTickets_SaleEndInHour(timeLeft.toString())),
              if (ticket.remainingCount <= 10)
                Text('${l10n.eventTickets_RemainingTickets}: '
                    '${ticket.remainingCount}'),
            ],
          ),
        ),
      ),
    );
  }
}
