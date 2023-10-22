import 'package:event_planr_app/domain/models/event/create_or_edit_event.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/event/event_category_enum.dart';
import 'package:event_planr_app/domain/models/event/organization_event_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/organize/create_or_delete_event/cubit/create_or_edit_event_cubit.dart';
import 'package:event_planr_app/ui/organize/create_or_delete_event/widgets/map_location_form_field.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:latlong2/latlong.dart';

class CreateOrEditEventForm extends StatefulWidget {
  const CreateOrEditEventForm({
    this.eventDetails,
    this.disabled = false,
    super.key,
  });

  final bool disabled;
  final OrganizationEventDetails? eventDetails;

  @override
  State<CreateOrEditEventForm> createState() => _CreateOrEditEventFormState();
}

class _CreateOrEditEventFormState extends State<CreateOrEditEventForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final bool _edit;

  @override
  void initState() {
    super.initState();
    _edit = widget.eventDetails != null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return FormBuilder(
      key: _formKey,
      initialValue: _edit
          ? {
              ...widget.eventDetails!.toJson(),
              'fromDate': widget.eventDetails!.fromDate,
              'toDate': widget.eventDetails!.toDate,
              ...widget.eventDetails!.address
                  .toJson()
                  .map((key, value) => MapEntry('address.$key', value)),
            }
          : {},
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
          _venueField(context),
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

      final address = _formKey.currentState!.value.entries
          .where((a) => a.key.startsWith('address'))
          .map((a) => MapEntry(a.key.split('.')[1], a.value));
      final coordinates = _formKey.currentState!.value.entries
          .where((c) => c.key.startsWith('coordinates'))
          .map((c) => MapEntry(c.key.split('.')[1], c.value));
      context.read<CreateOrEditEventCubit>().createOrEditEvent(
            CreateOrEditEvent.fromJson({
              ..._formKey.currentState!.value,
              'address': Map.fromEntries(address),
              'coordinates': Map.fromEntries(coordinates),
              if (_edit)
                'id': widget.eventDetails!.id,
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
        hintText: l10n.createOrEditEvent_Name,
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
        hintText: l10n.createOrEditEvent_Description,
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
              value: e.name,
              child: Text(l10n.translateEnums(e.name)),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        hintText: l10n.createOrEditEvent_Category,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required<String>(),
      ]),
    );
  }

  Widget _fromDateField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderDateTimePicker(
      name: 'fromDate',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createOrEditEvent_FromDate,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        (value) {
          if (value!.isAfter(
            _formKey.currentState!.fields['toDate']!.value as DateTime,
          )) {
            return l10n.createOrEditEvent_FromDateMustBeBeforeToDate;
          }
          if (value.isBefore(DateTime.now())) {
            return l10n.createOrEditEvent_FromDateMustBeAfterCurrentDate;
          }

          return null;
        }
      ]),
      valueTransformer: (value) => value.toString(),
    );
  }

  Widget _toDateField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderDateTimePicker(
      name: 'toDate',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createOrEditEvent_ToDate,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        (value) {
          if (value!.isBefore(
            _formKey.currentState!.fields['fromDate']!.value as DateTime,
          )) {
            return l10n.createOrEditEvent_ToDateMustBeAfterFromDate;
          }

          return null;
        }
      ]),
      valueTransformer: (value) => value.toString(),
    );
  }

  Widget _locationField(BuildContext context) {
    return BlocListener<CreateOrEditEventCubit, CreateOrEditEventState>(
      listener: (context, state) {
        if (state.location != null) {
          _formKey.currentState?.patchValue({
            'venue': state.location!.displayName.split(',')[0],
            'address.country': state.location!.address.country,
            'address.city': state.location!.address.city,
            'address.zipCode': state.location!.address.zipCode,
            'address.addressLine': '${state.location!.address.road} '
                '${state.location!.address.houseNumber}',
          });
        }
      },
      child: SizedBox(
        height: 300,
        child: MapLocationFormField(
          initialLocation: _edit ? LatLng(
            widget.eventDetails!.coordinates.latitude,
            widget.eventDetails!.coordinates.longitude,
          ) : null,
          latitudeFieldName: 'coordinates.latitude',
          longitudeFieldName: 'coordinates.longitude',
          locationPicked: (location) {
            context.read<CreateOrEditEventCubit>().getLocationAddress(location);
          },
        ),
      ),
    );
  }

  Widget _venueField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'venue',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createOrEditEvent_Venue,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(64),
      ]),
    );
  }

  Widget _countryField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'address.country',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.createOrEditEvent_Country,
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
        hintText: l10n.createOrEditEvent_ZipCode,
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
        hintText: l10n.createOrEditEvent_City,
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
        hintText: l10n.createOrEditEvent_AddressLine,
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
            (c) => DropdownMenuItem(
              value: c.name,
              child: Text(l10n.translateEnums(c.name)),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        hintText: l10n.createOrEditEvent_Currency,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required<String>(),
      ]),
    );
  }

  Widget _isPrivateField(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return FormBuilderCheckbox(
      name: 'isPrivate',
      initialValue: _edit ? null : false,
      title: Text(
        l10n.createOrEditEvent_IsPrivate,
        style: theme.textTheme.titleMedium,
      ),
      enabled: !widget.disabled,
    );
  }
}
