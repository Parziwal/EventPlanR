import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({this.disabled = false, super.key});

  final bool disabled;

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
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
          ElevatedButton(
            onPressed: widget.disabled ? null : _submit,
            style: ElevatedButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.primaryContainer,
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
      final email = _formKey.currentState!.value['email'] as String;
      context.read<AuthCubit>().forgotPassword(email);
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
}
