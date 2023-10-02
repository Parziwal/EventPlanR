import 'package:event_planr_app/domain/models/event/event_category.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateEventForm extends StatefulWidget {
  const CreateEventForm({this.disabled = false, super.key});

  final bool disabled;

  @override
  State<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
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
          _nameField(context),
          const SizedBox(height: 16),
          _descriptionField(context),
          const SizedBox(height: 16),
          _categoryField(context),
          const SizedBox(height: 16),
          _fromDateField(context),
          const SizedBox(height: 16),
          _toDateField(context),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: !widget.disabled ? _create : null,
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
            ),
            child: Text(l10n.create),
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

  Widget _nameField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'name',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createEventName,
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

  Widget _descriptionField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'description',
      enabled: !widget.disabled,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: l10n.createEventDescription,
        filled: true,
      ),
    );
  }

  Widget _categoryField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderDropdown(
      name: 'category',
      enabled: !widget.disabled,
      items: EventCategory.values
          .map(
            (e) => DropdownMenuItem(
              value: e.index,
              child: Text(e.name),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        hintText: l10n.createEventCategory,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required<int>(),
      ]),
    );
  }

  Widget _fromDateField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderDateTimePicker(
      name: 'fromDate',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createEventFromDate,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }

  Widget _toDateField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderDateTimePicker(
      name: 'toDate',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createEventToDate,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }

  Widget _addressField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'address',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: '-',
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }
}
