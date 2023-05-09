import 'package:event_planr/domain/ticket/models/event_ticket.dart';
import 'package:event_planr/ui/main/event_ticket/widgets/quantity_selector.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({required this.ticket, super.key});

  final EventTicket ticket;

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    ticket.name,
                    style: context.theme.textTheme.titleLarge,
                  ),
                  QuantitySelector(ticketName: ticket.name,),
                ],
              ),
              Text(
                '${ticket.price} HUF',
                style: context.theme.textTheme.titleMedium,
              ),
              Text(
                ticket.description,
                style: context.theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
