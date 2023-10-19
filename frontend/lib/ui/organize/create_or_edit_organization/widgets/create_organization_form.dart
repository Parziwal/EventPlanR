import 'package:event_planr_app/domain/models/organization/create_or_edit_organization.dart';
import 'package:event_planr_app/domain/models/organization/organization_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_organization/cubit/create_or_edit_organization_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateOrEditOrganizationForm extends StatefulWidget {
  const CreateOrEditOrganizationForm({
    this.disabled = false,
    this.organizationDetails,
    super.key,
  });

  final bool disabled;
  final OrganizationDetails? organizationDetails;

  @override
  State<CreateOrEditOrganizationForm> createState() =>
      _CreateOrEditOrganizationFormState();
}

class _CreateOrEditOrganizationFormState
    extends State<CreateOrEditOrganizationForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final bool _edit;

  @override
  void initState() {
    super.initState();
    _edit = widget.organizationDetails != null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return FormBuilder(
      key: _formKey,
      initialValue: _edit ? widget.organizationDetails!.toJson() : {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _nameField(context),
          const SizedBox(height: 16),
          _descriptionField(context),
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
      context.read<CreateOrEditOrganizationCubit>().createOrEditOrganization(
            CreateOrEditOrganization.fromJson(
              _formKey.currentState!.value,
            ),
          );
    }
  }

  Widget _nameField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'name',
      enabled: !widget.disabled && !_edit,
      decoration: InputDecoration(
        hintText: l10n.createOrEditOrganization_Name,
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
        hintText: l10n.createOrEditOrganization_Description,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.maxLength(256),
        ],
      ),
    );
  }
}
