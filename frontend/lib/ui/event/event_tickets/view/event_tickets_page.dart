import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/ticket/ticket.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/event_tickets/cubit/event_tickets_cubit.dart';
import 'package:event_planr_app/ui/event/event_tickets/widgets/ticket_item.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/max_width_box.dart';

class EventTicketsPage extends StatelessWidget {
  const EventTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final goRouterState = context.goRouterState;

    return BlocConsumer<EventTicketsCubit, EventTicketsState>(
      listener: _stateListener,
      builder: (context, state) {
        return EventScaffold(
          title: l10n.eventTickets,
          body: Builder(
            builder: (context) {
              if (state.status == EventTicketsStatus.loading) {
                return const LoadingIndicator();
              } else if (state.tickets != null) {
                return _mainContent(context, state);
              }

              return Container();
            },
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
                      Text(
                        l10n.eventTickets_Total,
                        style: theme.textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Text(
                        '${state.totalPrice} HUF',
                        style: theme.textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.go(
                    PagePaths.eventTicketCheckout(
                      goRouterState.pathParameters['eventId']!,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    textStyle: theme.textTheme.titleMedium,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: Text(l10n.eventTickets_Checkout),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mainContent(BuildContext context, EventTicketsState state) {
    final l10n = context.l10n;
    final theme = context.theme;
    final goRouterState = context.goRouterState;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: theme.colorScheme.inversePrimary,
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: MaxWidthBox(
              maxWidth: 600,
              child: Row(
                children: [
                  Text(
                    '${l10n.eventTickets_Total}: ${state.totalPrice} HUF',
                    style: theme.textTheme.titleLarge,
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => context.go(
                      PagePaths.eventTicketCheckout(
                        goRouterState.pathParameters['eventId']!,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      textStyle: theme.textTheme.titleMedium,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 64,
                        vertical: 16,
                      ),
                    ),
                    child: Text(l10n.eventTickets_Checkout),
                  ),
                ],
              ),
            ),
          ),
          MaxWidthBox(
            maxWidth: 600,
            child: Column(
              children: [
                ...state.tickets!.map(
                  (t) => TicketItem(
                    ticket: t,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    EventTicketsState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == EventTicketsStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.errorCode!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    }
  }
}
