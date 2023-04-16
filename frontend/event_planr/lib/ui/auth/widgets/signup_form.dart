import 'package:event_planr/domain/auth/models/signup_credentials.dart';
import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({this.disabled = false, super.key});

  final bool disabled;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
          _fullNameField(context),
          const SizedBox(height: 16),
          _emailField(context),
          const SizedBox(height: 16),
          _passwordField(context),
          const SizedBox(height: 16),
          _confirmPasswordField(context),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: widget.disabled ? null : _submit,
            style: ElevatedButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.primaryContainer,
            ),
            child: Text(l10.authSignUp),
          ),
          const SizedBox(height: 32),
          Text(
            l10.authAlreadyHaveAnAccount,
            style: TextStyle(
              color: theme.colorScheme.tertiary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: widget.disabled ? null : () => context.go('/auth/login'),
            child: Text(l10.authLogin),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthCubit>().signUp(
            SignUpCredentials.fromJson(
              _formKey.currentState!.value,
            ),
          );
    }
  }

  Widget _fullNameField(BuildContext context) {
    final l10 = context.l10n;
    return FormBuilderTextField(
      name: 'fullName',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10.authFullName,
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
      ),
      keyboardType: TextInputType.name,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(128),
        ],
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    final l10 = context.l10n;
    return FormBuilderTextField(
      name: 'email',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10.authEmail,
        prefixIcon: const Icon(Icons.email_outlined),
        filled: true,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
          FormBuilderValidators.maxLength(128),
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
