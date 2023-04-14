import 'package:event_planr/domain/auth/models/user_signup_credentials.dart';
import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({required this.disable, super.key});

  final bool disable;

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
          _fullNameField(l10),
          const SizedBox(height: 16),
          _emailField(l10),
          const SizedBox(height: 16),
          _passwordField(l10),
          const SizedBox(height: 16),
          _confirmPasswordField(l10),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: disable
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<AuthCubit>().signUp(
                            UserSignUpCredentials.fromJson(
                              _formKey.currentState!.value,
                            ),
                          );
                    }
                  },
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
            onPressed: () => context.pushReplacement('/auth/login'),
            child: Text(l10.authLogin),
          ),
        ],
      ),
    );
  }

  Widget _fullNameField(AppLocalizations l10) {
    return FormBuilderTextField(
      name: 'fullName',
      decoration: InputDecoration(
        hintText: l10.authFullName,
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
      ),
      keyboardType: TextInputType.name,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(
            errorText: l10.authFieldRequired(l10.authFullName),
          ),
          FormBuilderValidators.maxLength(
            128,
            errorText: l10.authFieldMaxLength(l10.authFullName, 128),
          ),
        ],
      ),
    );
  }

  Widget _emailField(AppLocalizations l10) {
    return FormBuilderTextField(
      name: 'email',
      decoration: InputDecoration(
        hintText: l10.authEmail,
        prefixIcon: const Icon(Icons.email_outlined),
        filled: true,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(
            errorText: l10.authFieldRequired(l10.authEmail),
          ),
          FormBuilderValidators.email(
            errorText: l10.authEmailNotValid,
          ),
          FormBuilderValidators.maxLength(
            128,
            errorText: l10.authFieldMaxLength(l10.authEmail, 128),
          ),
        ],
      ),
    );
  }

  Widget _passwordField(AppLocalizations l10) {
    return FormBuilderTextField(
      name: 'password',
      decoration: InputDecoration(
        hintText: l10.authPassword,
        prefixIcon: const Icon(Icons.lock_outline),
        filled: true,
      ),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(
            errorText: l10.authFieldRequired(l10.authPassword),
          ),
          FormBuilderValidators.minLength(
            8,
            errorText: l10.authFieldMinLength(l10.authPassword, 8),
          ),
          FormBuilderValidators.maxLength(
            128,
            errorText: l10.authFieldMaxLength(l10.authPassword, 128),
          ),
          (password) {
            if (password == null) {
              return null;
            } else if (!password.contains(RegExp('[A-Z]'))) {
              return l10.authPasswordMustContainCapital;
            } else if (!password.contains(RegExp('[0-9]'))) {
              return l10.authPasswordMustContainNumber;
            }
            return null;
          }
        ],
      ),
    );
  }

  Widget _confirmPasswordField(AppLocalizations l10) {
    return FormBuilderTextField(
      name: 'confirmPassword',
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
