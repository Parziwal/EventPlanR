import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/auth/user_sign_in_credential.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({this.disabled = false, super.key});

  final bool disabled;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
          _emailField(context),
          const SizedBox(height: 16),
          _passwordField(context),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: widget.disabled ? null : _submit,
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
            ),
            child: Text(l10.authSignIn),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: widget.disabled
                ? null
                : () => context.push(PagePaths.forgotPassword),
            child: Text(l10.authForgotYourPassword),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthCubit>().signIn(
            UserSignInCredential.fromJson(
              _formKey.currentState!.value,
            ),
          );
    }
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
        ],
      ),
      onSubmitted: (_) => _submit(),
    );
  }
}
