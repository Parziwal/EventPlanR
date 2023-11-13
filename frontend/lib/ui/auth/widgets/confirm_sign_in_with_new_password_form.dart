import 'package:event_planr_app/domain/models/auth/confirm_sign_in_credential.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ConfirmSignInWithNewPasswordForm extends StatefulWidget {
  const ConfirmSignInWithNewPasswordForm({this.disabled = false, super.key});

  final bool disabled;

  @override
  State<ConfirmSignInWithNewPasswordForm> createState() =>
      _ConfirmSignInWithNewPasswordFormState();
}

class _ConfirmSignInWithNewPasswordFormState
    extends State<ConfirmSignInWithNewPasswordForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;
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
          _passwordField(context),
          const SizedBox(height: 16),
          _confirmPasswordField(context),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: widget.disabled ? null : _submit,
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
            ),
            child: Text(l10.auth_ConfirmSignIn),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthCubit>().confirmSignInWithNewPassword(
            ConfirmSignInCredential.fromJson(
              _formKey.currentState!.value,
            ),
          );
    }
  }

  Widget _firstNameField(BuildContext context) {
    final l10 = context.l10n;
    return FormBuilderTextField(
      name: 'firstName',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10.auth_FirstName,
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
      ),
      keyboardType: TextInputType.name,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(64),
        ],
      ),
    );
  }

  Widget _lastNameField(BuildContext context) {
    final l10 = context.l10n;
    return FormBuilderTextField(
      name: 'lastName',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10.auth_LastName,
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
      ),
      keyboardType: TextInputType.name,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(64),
        ],
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    final l10 = context.l10n;
    return FormBuilderTextField(
      name: 'password',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10.auth_Password,
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
        hintText: l10.auth_ConfirmPassword,
        prefixIcon: const Icon(Icons.lock_outline),
        filled: true,
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: FormBuilderValidators.compose(
        [
          (confirmPassword) {
            if (confirmPassword !=
                _formKey.currentState?.fields['password']?.value) {
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
