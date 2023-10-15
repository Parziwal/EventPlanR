import 'package:event_planr_app/ui/event/event_tickets/widgets/quantity_selector.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme  = context.theme;

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
                    'Ticket name',
                    style: theme.textTheme.titleLarge,
                  ),
                  const QuantitySelector(),
                ],
              ),
              Text(
                '1000 HUF',
                style: theme.textTheme.titleMedium,
              ),
              Text(
                'Description',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
