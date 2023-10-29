import 'dart:async';

import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/ticket_checkout/cubit/ticket_checkout_cubit.dart';
import 'package:event_planr_app/ui/event/ticket_checkout/widgets/ticket_checkout_form.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/max_width_box.dart';

class TicketCheckoutPage extends StatefulWidget {
  const TicketCheckoutPage({super.key});

  @override
  State<TicketCheckoutPage> createState() => _TicketCheckoutPageState();
}

class _TicketCheckoutPageState extends State<TicketCheckoutPage> {
  late Timer _timer;
  late int _timeLeft;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) {
      return;
    }
    _initialized = true;

    _timeLeft = context
        .read<TicketCheckoutCubit>()
        .state
        .expirationTime!
        .difference(
          DateTime.now(),
        )
        .inSeconds;

    if (_timeLeft.isNegative) {
      context.pop();
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_timeLeft == 0) {
          setState(() {
            timer.cancel();
          });
          context.pop();
        } else {
          setState(() {
            _timeLeft--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return EventScaffold(
      title: l10n.ticketCheckout,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: theme.colorScheme.inversePrimary,
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: MaxWidthBox(
                maxWidth: 600,
                child: Text(
                  '${l10n.ticketCheckout_TimeLeft}: '
                  '${Duration(seconds: _timeLeft).inMinutes}:'
                  '${_timeLeft % 60}',
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: MaxWidthBox(
                maxWidth: 600,
                child: BlocConsumer<TicketCheckoutCubit, TicketCheckoutState>(
                  listener: _stateListener,
                  builder: (context, state) {
                    return TicketCheckoutForm(
                      reservedTickets: state.reservedTickets,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    TicketCheckoutState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == TicketCheckoutStatus.error) {
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
    } else if (state.status == TicketCheckoutStatus.ticketsOrdered) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.ticketCheckout_OrderWasSuccessful,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      context.go(
        PagePaths.userEventTickets(
          context.goRouterState.pathParameters['eventId']!,
        ),
      );
    }
  }
}
