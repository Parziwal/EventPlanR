import 'package:event_planr_app/domain/models/organization/edit_organization.dart';
import 'package:event_planr_app/domain/models/organization/organization_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/edit_organization/cubit/edit_organization_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditOrganizationForm extends StatefulWidget {
  const EditOrganizationForm({
    required this.organization,
    this.disabled = false,
    super.key,
  });

  final bool disabled;
  final OrganizationDetails organization;

  @override
  State<EditOrganizationForm> createState() => _EditOrganizationFormState();
}

class _EditOrganizationFormState extends State<EditOrganizationForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return FormBuilder(
      key: _formKey,
      initialValue: widget.organization.toJson(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _profileImage(context),
          const SizedBox(height: 16),
          _nameField(context),
          const SizedBox(height: 16),
          _descriptionField(context),
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
      context.read<EditOrganizationCubit>().editOrganization(
            EditOrganization.fromJson({
              ...widget.organization.toJson(),
              ..._formKey.currentState!.value,
            }),
          );
    }
  }

  Widget _profileImage(BuildContext context) {
    return Container();
  }

  Widget _nameField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'name',
      enabled: false,
      decoration: InputDecoration(
        hintText: l10n.editOrganizationName,
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
        hintText: l10n.editOrganizationDescription,
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
