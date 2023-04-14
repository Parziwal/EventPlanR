import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ConfirmForm extends StatelessWidget {
  ConfirmForm({super.key});

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
          _confirmCodeField(l10),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final formValue = _formKey.currentState!.value;
                context
                    .read<AuthCubit>()
                    .confirmCode(formValue['confirmCode'] as String);
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
        ],
      ),
    );
  }

  Widget _confirmCodeField(AppLocalizations l10) {
    return FormBuilderTextField(
      name: 'confirmCode',
      decoration: InputDecoration(
        hintText: l10.authConfirmCode,
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
      ),
      keyboardType: TextInputType.number,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(
            errorText: l10.authFieldRequired(l10.authConfirmCode),
          ),
        ],
      ),
    );
  }
}
