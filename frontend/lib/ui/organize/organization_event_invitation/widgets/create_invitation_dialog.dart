import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organization_event_invitation/cubit/organization_event_invitation_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

Future<void> showCreateInvitationDialog(BuildContext context) {
  final invitationCubit = context.read<OrganizationEventInvitationCubit>();

  return showDialog(
    context: context,
    builder: (contextModal) {
      return BlocProvider.value(
        value: invitationCubit,
        child: Dialog(
          clipBehavior: Clip.hardEdge,
          child: BlocBuilder<OrganizationEventInvitationCubit,
              OrganizationEventInvitationState>(
            builder: (context, state) => _CreateInvitationDialog(
              submit: invitationCubit.createInvitation,
            ),
          ),
        ),
      );
    },
  );
}

class _CreateInvitationDialog extends StatefulWidget {
  const _CreateInvitationDialog({
    required this.submit,
  });

  final void Function(String userEmail) submit;

  @override
  State<_CreateInvitationDialog> createState() =>
      _CreateInvitationDialogState();
}

class _CreateInvitationDialogState extends State<_CreateInvitationDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return SizedBox(
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: theme.colorScheme.inversePrimary,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  l10n.organizationEventInvitation_CreateInvitation,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _emailField(context),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: _submit,
                    style: FilledButton.styleFrom(
                      textStyle: theme.textTheme.titleMedium,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: Text(l10n.submit),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      style: FilledButton.styleFrom(
                        textStyle: theme.textTheme.titleMedium,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                      child: Text(l10n.cancel),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.submit(_formKey.currentState!.value['email'] as String);
    }
  }

  Widget _emailField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'email',
      decoration: InputDecoration(
        hintText: l10n.organizationEventInvitation_Email,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
        ],
      ),
    );
  }
}
