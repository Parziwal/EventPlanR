import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ConfirmSignUpForm extends StatefulWidget {
  const ConfirmSignUpForm({this.disabled = false, super.key});

  final bool disabled;

  @override
  State<ConfirmSignUpForm> createState() =>
      _ConfirmSignUpFormState();
}

class _ConfirmSignUpFormState extends State<ConfirmSignUpForm> {
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
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: widget.disabled
                ? null
                : context.read<AuthCubit>().resendConfirmationCode,
            style: ElevatedButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
            ),
            child: Text(l10.auth_ResendConfirmCode),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: widget.disabled ? null : _submit,
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
            ),
            child: Text(l10.submit),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final confirmCode = _formKey.currentState!.value['confirmCode'] as String;
      context.read<AuthCubit>().confirmSignUp(confirmCode);
    }
  }

  Widget _confirmCodeField(BuildContext context) {
    final l10 = context.l10n;

    return FormBuilderTextField(
      name: 'confirmCode',
      enabled: !widget.disabled,
      decoration: InputDecoration(
        hintText: l10.auth_ConfirmCode,
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
      onSubmitted: (_) => _submit(),
    );
  }
}
