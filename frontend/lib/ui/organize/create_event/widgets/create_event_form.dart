import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/event/event_category_enum.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/create_event/cubit/create_event_cubit.dart';
import 'package:event_planr_app/ui/organize/create_event/widgets/map_location_form_field.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          const SizedBox(height: 16),
          _locationField(context),
          const SizedBox(height: 16),
          _countryField(context),
          const SizedBox(height: 16),
          _zipCodeField(context),
          const SizedBox(height: 16),
          _cityField(context),
          const SizedBox(height: 16),
          _addressLineField(context),
          const SizedBox(height: 16),
          _currencyField(context),
          const SizedBox(height: 16),
          _isPrivateField(context),
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
        hintText: l10n.createEvent_Name,
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
        hintText: l10n.createEvent_Description,
        filled: true,
      ),
    );
  }

  Widget _categoryField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderDropdown(
      name: 'category',
      enabled: !widget.disabled,
      items: EventCategoryEnum.values
          .map(
            (e) => DropdownMenuItem(
              value: e.index,
              child: Text(e.name),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        hintText: l10n.createEvent_Category,
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
        hintText: l10n.createEvent_FromDate,
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
        hintText: l10n.createEvent_ToDate,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }

  Widget _locationField(BuildContext context) {
    return BlocListener<CreateEventCubit, CreateEventState>(
      listener: (context, state) {
        if (state.address != null) {
          _formKey.currentState?.patchValue({
            'address.country': state.address!.country,
            'address.city': state.address!.city,
            'address.zipCode': state.address!.zipCode,
            'address.addressLine':
                '${state.address!.road} ${state.address!.houseNumber}',
          });
        }
      },
      child: SizedBox(
        height: 300,
        child: MapLocationFormField(
          latitudeFieldName: 'coordinates.latitude',
          longitudeFieldName: 'coordinates.longitude',
          locationPicked: (location) {
            context.read<CreateEventCubit>().getLocationAddress(location);
          },
        ),
      ),
    );
  }

  Widget _countryField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'address.country',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createEvent_Country,
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
      name: 'address.zipCode',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createEvent_ZipCode,
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
      name: 'address.city',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createEvent_City,
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
      name: 'address.addressLine',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createEvent_AddressLine,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(256),
      ]),
    );
  }

  Widget _currencyField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderDropdown(
      name: 'currency',
      enabled: !widget.disabled,
      items: CurrencyEnum.values
          .map(
            (e) => DropdownMenuItem(
              value: e.index,
              child: Text(e.name),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        hintText: l10n.createEvent_Currency,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required<int>(),
      ]),
    );
  }

  Widget _isPrivateField(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return FormBuilderCheckbox(
      name: 'isPrivate',
      title: Text(
        l10n.createEvent_IsPrivate,
        style: theme.textTheme.titleMedium,
      ),
      enabled: !widget.disabled,
    );
  }
}
