import 'package:event_planr_app/domain/models/order/order_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/user_ticket_order/cubit/user_ticket_order_cubit.dart';
import 'package:event_planr_app/ui/event/user_ticket_order/widgets/order_details_item.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/max_width_box.dart';

class UserTicketOrderPage extends StatelessWidget {
  const UserTicketOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EventScaffold(
      title: l10n.userTicketOrder,
      body: BlocConsumer<UserTicketOrderCubit, UserTicketOrderState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == UserTicketOrderStatus.loading) {
            return const LoadingIndicator();
          } else {
            return _mainContent(context, state.orders);
          }
        },
      ),
    );
  }

  Widget _mainContent(BuildContext context, List<OrderDetails> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) => MaxWidthBox(
        maxWidth: 1000,
        child: OrderDetailsItem(
          orderDetails: orders[index],
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    UserTicketOrderState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == UserTicketOrderStatus.error) {
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
