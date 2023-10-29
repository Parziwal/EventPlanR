import 'package:event_planr_app/domain/models/ticket/add_or_edit_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/organization_ticket.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_ticket/cubit/create_or_edit_ticket_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateOrEditTicketForm extends StatefulWidget {
  const CreateOrEditTicketForm({
    required this.disabled,
    this.ticket,
    super.key,
  });

  final bool disabled;
  final OrganizationTicket? ticket;

  @override
  State<CreateOrEditTicketForm> createState() => _CreateOrEditTicketFormState();
}

class _CreateOrEditTicketFormState extends State<CreateOrEditTicketForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final bool _edit;

  @override
  void initState() {
    super.initState();
    _edit = widget.ticket != null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return FormBuilder(
      key: _formKey,
      initialValue: _edit
          ? {
              ...widget.ticket!.toJson(),
              'count': widget.ticket!.count.toString(),
              'price': widget.ticket!.price.toString(),
              'saleStarts': widget.ticket!.saleStarts,
              'saleEnds': widget.ticket!.saleEnds,
            }
          : {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _nameField(context),
          const SizedBox(height: 16),
          _priceField(context),
          const SizedBox(height: 16),
          _countField(context),
          const SizedBox(height: 16),
          _descriptionField(context),
          const SizedBox(height: 16),
          _salesStartsField(context),
          const SizedBox(height: 16),
          _salesEndsField(context),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: !widget.disabled ? _submit : null,
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final eventId = context.goRouterState.pathParameters['eventId']!;
      context.read<CreateOrEditTicketCubit>().createOrEditTicket(
            AddOrEditTicket.fromJson({
              ..._formKey.currentState!.value,
              'eventId': eventId,
              if (_edit)
                'id': widget.ticket!.id,
            }),
          );
    }
  }

  Widget _nameField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'name',
      enabled: !widget.disabled && !_edit,
      decoration: InputDecoration(
        hintText: l10n.createOrEditTicket_Name,
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

  Widget _priceField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'price',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createOrEditTicket_Price,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.numeric(),
          FormBuilderValidators.min(0),
        ],
      ),
      valueTransformer: (value) => double.parse(value!),
    );
  }

  Widget _countField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'count',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createOrEditTicket_Count,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.numeric(),
          FormBuilderValidators.min(0),
        ],
      ),
      valueTransformer: (value) => int.parse(value!),
    );
  }

  Widget _descriptionField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'description',
      enabled: !widget.disabled,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: l10n.createOrEditTicket_Description,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.maxLength(256),
        ],
      ),
    );
  }

  Widget _salesStartsField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderDateTimePicker(
      name: 'saleStarts',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createOrEditTicket_SalesStarts,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        (value) {
          if (value!.isAfter(
            _formKey.currentState!.fields['saleEnds']!.value as DateTime,
          )) {
            return l10n.createOrEditTicket_SalesStartMustBeBeforeSalesEnds;
          }

          return null;
        }
      ]),
      valueTransformer: (value) => value!.toUtc().toString(),
    );
  }

  Widget _salesEndsField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderDateTimePicker(
      name: 'saleEnds',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createOrEditTicket_SalesEnds,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        (value) {
          if (value!.isBefore(
            _formKey.currentState!.fields['saleStarts']!.value as DateTime,
          )) {
            return l10n.createOrEditTicket_SalesEndsMustBeAfterSalesStart;
          }

          return null;
        }
      ]),
      valueTransformer: (value) => value!.toUtc().toString(),
    );
  }
}
