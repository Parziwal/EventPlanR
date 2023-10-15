import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/ticket_checkout/widgets/ticket_checkout_form.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/max_width_box.dart';

class TicketCheckoutPage extends StatelessWidget {
  const TicketCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventScaffold(
      title: 'Checkout',
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: MaxWidthBox(
          maxWidth: 600,
          child: TicketCheckoutForm(),
        ),
      ),
    );
  }
}
