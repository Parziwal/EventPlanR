import 'package:event_planr_app/domain/models/auth/user_forgot_password_credential.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ConfirmForgotPasswordForm extends StatefulWidget {
  const ConfirmForgotPasswordForm({this.disabled = false, super.key});

  final bool disabled;

  @override
  State<ConfirmForgotPasswordForm> createState() =>
      _ConfirmForgotPasswordFormState();
}

class _ConfirmForgotPasswordFormState extends State<ConfirmForgotPasswordForm> {
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
          _confirmCodeField(context),
          const SizedBox(height: 16),
          _newPasswordField(context),
          const SizedBox(height: 16),
          _confirmPasswordField(context),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: widget.disabled ? null : _submit,
            style: ElevatedButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
            child: Text(l10.authSubmit),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthCubit>().confirmForgotPassword(
            UserForgotPasswordCredential.fromJson(_formKey.currentState!.value),
          );
    }
  }

  Widget _confirmCodeField(BuildContext context) {
    final l10 = context.l10n;
    return FormBuilderTextField(
      name: 'confirmCode',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10.authConfirmCode,
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
      ),
      keyboardType: TextInputType.number,
      maxLength: 6,
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
        hintText: l10.authPassword,
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
              return l10.authPasswordMustContainUpperCase;
            } else if (!password.contains(RegExp('[a-z]'))) {
              return l10.authPasswordMustContainLowerCase;
            } else if (!password.contains(RegExp('[0-9]'))) {
              return l10.authPasswordMustContainNumber;
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
        hintText: l10.authConfirmPassword,
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
              return l10.authPasswordsDoNotMatch;
            }
            return null;
          }
        ],
      ),
    );
  }
}
