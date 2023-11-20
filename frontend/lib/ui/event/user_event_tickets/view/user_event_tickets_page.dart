import 'package:card_swiper/card_swiper.dart';
import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/ticket/sold_ticket.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/user_event_tickets/cubit/user_event_tickets_cubit.dart';
import 'package:event_planr_app/ui/event/user_event_tickets/widgets/user_ticket_landscape.dart';
import 'package:event_planr_app/ui/event/user_event_tickets/widgets/user_ticket_portrait.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/max_width_box.dart';

class UserEventTicketsPage extends StatelessWidget {
  const UserEventTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final breakpoints = context.breakpoints;
    final eventId = context.goRouterState.pathParameters['eventId']!;

    return EventScaffold(
      title: l10n.userEventTickets,
      mobileActions: [
        IconButton(
          onPressed: () => context.go(PagePaths.userEventTicketOrders(eventId)),
          icon: const Icon(Icons.info),
        ),
      ],
      body: BlocConsumer<UserEventTicketsCubit, UserEventTicketsState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == UserEventTicketsStatus.loading) {
            return const LoadingIndicator();
          } else {
            return breakpoints.isMobile
                ? _portraitUserTicket(context, state.soldTickets)
                : _landscapeUserTicket(context, state.soldTickets);
          }
        },
      ),
    );
  }

  Widget _landscapeUserTicket(
    BuildContext context,
    List<SoldTicket> soldTickets,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;
    final eventId = context.goRouterState.pathParameters['eventId']!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                onPressed: () => context.go(
                  PagePaths.userEventTicketOrders(
                    eventId,
                  ),
                ),
                style: FilledButton.styleFrom(
                  textStyle: theme.textTheme.titleMedium,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 64,
                    vertical: 16,
                  ),
                ),
                child: Text(l10n.userEventTickets_OrderInformations),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            children: [
              ...soldTickets.map(
                (t) => MaxWidthBox(
                  maxWidth: 500,
                  child: UserTicketLandscape(
                    ticket: t,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _portraitUserTicket(
    BuildContext context,
    List<SoldTicket> soldTickets,
  ) {
    final media = context.mediaQuery;
    final ticketsCount = soldTickets.length;

    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${ticketsCount - index}/$ticketsCount'),
                UserTicketPortrait(
                  ticket: soldTickets[ticketsCount - index - 1],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: ticketsCount,
      index: ticketsCount - 1,
      itemWidth: media.size.width - 32,
      layout: SwiperLayout.STACK,
      loop: false,
    );
  }

  void _stateListener(
    BuildContext context,
    UserEventTicketsState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == UserEventTicketsStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.exception!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    }
  }
}
