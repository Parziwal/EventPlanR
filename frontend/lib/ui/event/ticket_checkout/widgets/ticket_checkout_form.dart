import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TicketCheckoutForm extends StatefulWidget {
  const TicketCheckoutForm({this.disabled = false, super.key});

  final bool disabled;

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
          const SizedBox(height: 32),
          Text(
            'Tickets',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
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
    }
  }

  Widget _firstNameField(BuildContext context) {
    return FormBuilderTextField(
      name: 'firstName',
      enabled: !widget.disabled,
      decoration: const InputDecoration(
        hintText: 'First name',
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

  Widget _lastNameField(BuildContext context) {
    return FormBuilderTextField(
      name: 'lastName',
      enabled: !widget.disabled,
      decoration: const InputDecoration(
        hintText: 'Last name',
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
    return FormBuilderTextField(
      name: 'address.country',
      enabled: !widget.disabled,
      decoration: const InputDecoration(
        hintText: 'Country',
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(64),
      ]),
    );
  }

  Widget _zipCodeField(BuildContext context) {
    return FormBuilderTextField(
      name: 'address.zipCode',
      enabled: !widget.disabled,
      decoration: const InputDecoration(
        hintText: 'Zip code',
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(10),
      ]),
    );
  }

  Widget _cityField(BuildContext context) {
    return FormBuilderTextField(
      name: 'address.city',
      enabled: !widget.disabled,
      decoration: const InputDecoration(
        hintText: 'City',
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(64),
      ]),
    );
  }

  Widget _addressLineField(BuildContext context) {
    return FormBuilderTextField(
      name: 'address.addressLine',
      enabled: !widget.disabled,
      decoration: const InputDecoration(
        hintText: 'Address line',
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(256),
      ]),
    );
  }

  Widget _userTickets(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ticket type',
          style: theme.textTheme.titleMedium
              ?.copyWith(color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16),
        _firstNameField(context),
        const SizedBox(height: 16),
        _lastNameField(context),
      ],
    );
  }
}
