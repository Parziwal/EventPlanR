import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/event_tickets/widgets/ticket_item.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/max_width_box.dart';

class EventTicketsPage extends StatelessWidget {
  const EventTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return EventScaffold(
      title: 'Tickets',
      body: Column(
        children: [
          Container(
            color: theme.colorScheme.inversePrimary,
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: MaxWidthBox(
              maxWidth: 600,
              child: Row(
                children: [
                  Text('Total: 1000 HUF', style: theme.textTheme.titleLarge),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => context.go(
                      PagePaths.eventTicketCheckout('Test'),
                    ),
                    style: FilledButton.styleFrom(
                      textStyle: theme.textTheme.titleMedium,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 64,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ),
          const MaxWidthBox(
            maxWidth: 600,
            child: TicketItem(),
          ),
        ],
      ),
      mobileBottomSheet: Container(
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
                  Text('Total', style: theme.textTheme.titleLarge),
                  const Spacer(),
                  Text(
                    '1000 HUF',
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go(
                PagePaths.eventTicketCheckout('Test'),
              ),
              style: FilledButton.styleFrom(
                textStyle: theme.textTheme.titleMedium,
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
