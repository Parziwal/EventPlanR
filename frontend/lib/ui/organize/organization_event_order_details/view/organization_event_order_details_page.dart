import 'package:event_planr_app/domain/models/order/order_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/organization_event_order_details/cubit/organization_event_order_details_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/label.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/max_width_box.dart';

class OrganizationEventOrderDetailsPage extends StatelessWidget {
  const OrganizationEventOrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OrganizeScaffold(
      title: l10n.organizationEventOrderDetails,
      body: BlocConsumer<OrganizationEventOrderDetailsCubit,
          OrganizationEventOrderDetailsState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == OrganizationEventOrderDetailsStatus.loading) {
            return const LoadingIndicator();
          } else if (state.orderDetails != null) {
            return _mainContent(context, state.orderDetails!);
          }

          return Container();
        },
      ),
    );
  }

  Widget _mainContent(BuildContext context, OrderDetails orderDetails) {
    final l10n = context.l10n;
    final theme = context.theme;

    return MaxWidthBox(
      maxWidth: 1000,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Label(
              label: '#${orderDetails.id}',
              value: '${l10n.organizationEventOrderDetails_Created}: '
                  '${DateFormat.yMd().format(orderDetails.created)}',
              textStyle: theme.textTheme.titleMedium,
              backgroundColor: theme.colorScheme.inversePrimary,
            ),
            Label(
              label: l10n.organizationEventOrderDetails_CustomerName,
              value: orderDetails.getUserFullName(context),
              textStyle: theme.textTheme.titleMedium,
              backgroundColor: theme.colorScheme.inversePrimary,
            ),
            const Divider(),
            Text(
              l10n.organizationEventOrderDetails_BillingAddress,
              style: theme.textTheme.titleMedium,
            ),
            Label(
              label: l10n.organizationEventOrderDetails_Country,
              value: orderDetails.billingAddress.country,
            ),
            Label(
              label: l10n.organizationEventOrderDetails_ZipCode,
              value: orderDetails.billingAddress.zipCode,
            ),
            Label(
              label: l10n.organizationEventOrderDetails_City,
              value: orderDetails.billingAddress.city,
            ),
            Label(
              label: l10n.organizationEventOrderDetails_AddressLine,
              value: orderDetails.billingAddress.addressLine,
            ),
            const Divider(),
            Text(
              l10n.organizationEventOrderDetails_Tickets,
              style: theme.textTheme.titleMedium,
            ),
            ...orderDetails.soldTickets.map(
              (t) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label(
                    label: t.ticketName,
                    value: '${t.price} ${l10n.translateEnums(
                      t.currency.name,
                    )}',
                  ),
                  Text('${l10n.organizationEventOrderDetails_Username}: '
                      '${t.getUserFullName(context)}'),
                  const Divider(),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Label(
              label: l10n.organizationEventOrderDetails_Total,
              value: '${orderDetails.total} '
                  '${l10n.translateEnums(orderDetails.currency.name)}',
              textStyle: theme.textTheme.titleMedium,
              backgroundColor: theme.colorScheme.secondaryContainer,
            ),
          ],
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    OrganizationEventOrderDetailsState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == OrganizationEventOrderDetailsStatus.error) {
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
