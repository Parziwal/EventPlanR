import 'package:event_planr_app/domain/models/auth/change_password.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/edit_security/cubit/edit_security_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditSecurityForm extends StatefulWidget {
  const EditSecurityForm({required this.disabled, super.key});

  final bool disabled;

  @override
  State<EditSecurityForm> createState() => _EditSecurityFormState();
}

class _EditSecurityFormState extends State<EditSecurityForm> {
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
          _oldPasswordField(context),
          const SizedBox(height: 16),
          _newPasswordField(context),
          const SizedBox(height: 16),
          _confirmPasswordField(context),
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
      context.read<EditSecurityCubit>().changeUserPassword(
            ChangePassword.fromJson(
              _formKey.currentState!.value,
            ),
          );
    }
  }

  Widget _oldPasswordField(BuildContext context) {
    final l10 = context.l10n;
    return FormBuilderTextField(
      name: 'oldPassword',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10.editSecurity_OldPassword,
        prefixIcon: const Icon(Icons.lock_outline),
        filled: true,
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
        ],
      ),
    );
  }

  Widget _newPasswordField(BuildContext context) {
    final l10 = context.l10n;
    return FormBuilderTextField(
      name: 'newPassword',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10.editSecurity_NewPassword,
        prefixIcon: const Icon(Icons.lock_outline),
        filled: true,
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(8),
          FormBuilderValidators.maxLength(128),
          (password) {
            if (password == null) {
              return null;
            } else if (!password.contains(RegExp('[A-Z]'))) {
              return l10.auth_PasswordMustContainUpperCase;
            } else if (!password.contains(RegExp('[a-z]'))) {
              return l10.auth_PasswordMustContainLowerCase;
            } else if (!password.contains(RegExp('[0-9]'))) {
              return l10.auth_PasswordMustContainNumber;
            }
            return null;
          }
        ],
      ),
    );
  }

  Widget _confirmPasswordField(BuildContext context) {
    final l10 = context.l10n;
    return FormBuilderTextField(
      name: 'confirmPassword',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10.editSecurity_ConfirmPassword,
        prefixIcon: const Icon(Icons.lock_outline),
        filled: true,
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: FormBuilderValidators.compose(
        [
          (confirmPassword) {
            if (confirmPassword !=
                _formKey.currentState?.fields['newPassword']?.value) {
              return l10.auth_PasswordsDoNotMatch;
            }
            return null;
          }
        ],
      ),
      onSubmitted: (_) => _submit(),
    );
  }
}
