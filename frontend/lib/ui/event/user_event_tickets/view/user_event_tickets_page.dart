import 'package:card_swiper/card_swiper.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/user_event_tickets/widgets/user_ticket_landscape.dart';
import 'package:event_planr_app/ui/event/user_event_tickets/widgets/user_ticket_portrait.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/max_width_box.dart';

class UserEventTicketsPage extends StatelessWidget {
  const UserEventTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoints = context.breakpoints;

    return EventScaffold(
      title: 'Tickets',
      mobileActions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.info),
        ),
      ],
      body: breakpoints.isMobile
          ? _portraitUserTicket(context)
          : _landscapeUserTicket(context),
    );
  }

  Widget _landscapeUserTicket(BuildContext context) {
    final theme = context.theme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  textStyle: theme.textTheme.titleMedium,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 64,
                    vertical: 16,
                  ),
                ),
                child: const Text('Order informations'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Wrap(
            children: [
              MaxWidthBox(maxWidth: 500, child: UserTicketLandscape()),
              MaxWidthBox(maxWidth: 500, child: UserTicketLandscape()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _portraitUserTicket(BuildContext context) {
    final media = context.mediaQuery;

    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${10 - index}/10'),
                const UserTicketPortrait(),
              ],
            ),
          ),
        );
      },
      itemCount: 10,
      index: 9,
      itemWidth: media.size.width - 32,
      layout: SwiperLayout.STACK,
    );
  }
}
