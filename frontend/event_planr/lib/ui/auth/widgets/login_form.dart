import 'package:event_planr/domain/auth/models/login_credentials.dart';
import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({this.disabled = false, super.key});

  final bool disabled;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.screenBodyHeight;
    final l10 = context.l10n;

    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/icon/icon.png',
            height: bodyHeight / 5,
          ),
          const SizedBox(height: 16),
          _emailField(context),
          const SizedBox(height: 16),
          _passwordField(context),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: widget.disabled ? null : _submit,
            style: ElevatedButton.styleFrom(
              textStyle: context.theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
              backgroundColor: context.theme.colorScheme.primary,
              foregroundColor: context.theme.colorScheme.primaryContainer,
            ),
            child: Text(l10.authLogin),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: widget.disabled
                ? null
                : () => context.push('/auth/forgot-password'),
            child: Text(l10.authForgotYourPassword),
          ),
          const SizedBox(height: 32),
          Text(
            l10.authDontHaveAnAccount,
            style: TextStyle(
              color: context.theme.colorScheme.tertiary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: widget.disabled
                ? null
                : () => context.go('/auth/signup'),
            child: Text(l10.authSignUp),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthCubit>().login(
            LoginCredentials.fromJson(
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
    );
  }
}
