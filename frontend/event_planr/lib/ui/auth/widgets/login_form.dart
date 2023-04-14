import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

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
          _emailField(l10),
          const SizedBox(height: 16),
          _passwordField(l10),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
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
            onPressed: () {},
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
            onPressed: () => context.pushReplacement('/auth/signup'),
            child: Text(l10.authSignUp),
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
        ],
      ),
    );
  }
}
