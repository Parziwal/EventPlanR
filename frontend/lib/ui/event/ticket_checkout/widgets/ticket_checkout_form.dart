import 'package:event_planr_app/domain/models/ticket/add_reserve_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/add_ticket_user_info.dart';
import 'package:event_planr_app/domain/models/ticket/create_order.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/ticket_checkout/cubit/ticket_checkout_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TicketCheckoutForm extends StatefulWidget {
  const TicketCheckoutForm({
    required this.reservedTickets,
    this.disabled = false,
    super.key,
  });

  final bool disabled;
  final List<AddReserveTicket> reservedTickets;

  @override
  State<TicketCheckoutForm> createState() => _TicketCheckoutFormState();
}

class _TicketCheckoutFormState extends State<TicketCheckoutForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _firstNameField(context),
          const SizedBox(height: 16),
          _lastNameField(context),
          const SizedBox(height: 16),
          _countryField(context),
          const SizedBox(height: 16),
          _zipCodeField(context),
          const SizedBox(height: 16),
          _cityField(context),
          const SizedBox(height: 16),
          _addressLineField(context),
          const SizedBox(height: 16),
          _userTickets(context),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: !widget.disabled ? _create : null,
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
            ),
            child: Text(l10n.submit),
          ),
        ],
      ),
    );
  }

  void _create() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final address = _formKey.currentState!.value.entries
          .where((a) => a.key.startsWith('billingAddress'))
          .map((a) => MapEntry(a.key.split('.')[1], a.value));

      context.read<TicketCheckoutCubit>().orderReservedTickets(
            CreateOrder.fromJson({
              ..._formKey.currentState!.value,
              'billingAddress': Map.fromEntries(address),
            }),
          );
    }
  }

  Widget _firstNameField(BuildContext context, {String postFix = ''}) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'firstName$postFix',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.ticketCheckout_FirstName,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(64),
        ],
      ),
    );
  }

  Widget _lastNameField(BuildContext context, {String postFix = ''}) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'lastName$postFix',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.ticketCheckout_LastName,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(64),
        ],
      ),
    );
  }

  Widget _countryField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'billingAddress.country',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.ticketCheckout_Country,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(64),
      ]),
    );
  }

  Widget _zipCodeField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'billingAddress.zipCode',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.ticketCheckout_ZipCode,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(10),
      ]),
    );
  }

  Widget _cityField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'billingAddress.city',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.ticketCheckout_City,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(64),
      ]),
    );
  }

  Widget _addressLineField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'billingAddress.addressLine',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.ticketCheckout_AddressLine,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(256),
      ]),
    );
  }

  Widget _userTickets(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return FormBuilderField(
      name: 'ticketUserInfos',
      valueTransformer: (_) {
        final ticketInfos = <Map<String, dynamic>>[];

        for (final ticket in widget.reservedTickets) {
          for (var i = 0; i < ticket.count; i++) {
            final ticketInfo = AddTicketUserInfo(
              ticketId: ticket.ticketId,
              userFirstName: _formKey.currentState!
                  .fields['firstName${ticket.ticketId}$i']!.value as String,
              userLastName: _formKey.currentState!
                  .fields['lastName${ticket.ticketId}$i']!.value as String,
            );
            ticketInfos.add(ticketInfo.toJson());
          }
        }

        return ticketInfos;
      },
      builder: (FormFieldState<dynamic> field) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: l10n.ticketCheckout_Tickets,
            labelStyle: theme.textTheme.headlineLarge,
            border: InputBorder.none,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              ...widget.reservedTickets.map(
                (t) => ListView.builder(
                  itemCount: t.count,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        t.ticketName,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(color: theme.colorScheme.primary),
                      ),
                      const SizedBox(height: 16),
                      _firstNameField(context, postFix: '${t.ticketId}$index'),
                      const SizedBox(height: 16),
                      _lastNameField(context, postFix: '${t.ticketId}$index'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
