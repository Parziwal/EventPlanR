import 'package:event_planr_app/domain/models/auth/edit_user.dart';
import 'package:event_planr_app/domain/models/auth/user.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/edit_user/cubit/edit_user_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditUserForm extends StatefulWidget {
  const EditUserForm({required this.user, required this.disabled, super.key});

  final bool disabled;
  final User? user;

  @override
  State<EditUserForm> createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return FormBuilder(
      key: _formKey,
      initialValue: widget.user != null
          ? {
              ...widget.user!.toJson(),
              'firstName': widget.user!.firstName,
              'lastName': widget.user!.lastName,
            }
          : {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _firstNameField(context),
          const SizedBox(height: 16),
          _lastNameField(context),
          const SizedBox(height: 16),
          _emailField(context),
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
      context.read<EditUserCubit>().editUser(
            EditUser.fromJson(
              _formKey.currentState!.value,
            ),
          );
    }
  }

  Widget _firstNameField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'firstName',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.editUser_FirstName,
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
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'lastName',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.editUser_LastName,
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

  Widget _emailField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'email',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10n.editUser_Email,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(128),
        ],
      ),
    );
  }
}
