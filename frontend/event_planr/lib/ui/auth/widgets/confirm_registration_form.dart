import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ConfirmRegistrationForm extends StatefulWidget {
  const ConfirmRegistrationForm({this.disabled = false, super.key});

  final bool disabled;

  @override
  State<ConfirmRegistrationForm> createState() =>
      _ConfirmRegistrationFormState();
}

class _ConfirmRegistrationFormState extends State<ConfirmRegistrationForm> {
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
          ElevatedButton(
            onPressed: widget.disabled
                ? null
                : context.read<AuthCubit>().resendConfirmationCode,
            style: ElevatedButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
            ),
            child: Text(l10.authResendConfirmCode),
          ),
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
      final confirmCode = _formKey.currentState!.value['confirmCode'] as String;
      context.read<AuthCubit>().confirmRegistration(confirmCode);
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
}
