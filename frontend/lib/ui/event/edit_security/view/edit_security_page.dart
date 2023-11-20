import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/event/edit_security/cubit/edit_security_cubit.dart';
import 'package:event_planr_app/ui/event/edit_security/widgets/edit_security_form.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EditSecurityPage extends StatelessWidget {
  const EditSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EventScaffold(
      title: l10n.editUser,
      body: BlocConsumer<EditSecurityCubit, EditSecurityState>(
        listener: _stateListener,
        builder: (context, state) => SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: MaxWidthBox(
            maxWidth: 600,
            child: EditSecurityForm(
              key: ValueKey(state.status),
              disabled: state.status == EditSecurityStatus.loading,
            ),
          ),
        ),
      ),
    );
  }

  void _stateListener(
      BuildContext context,
      EditSecurityState state,
      ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == EditSecurityStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.exception!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    } else if (state.status == EditSecurityStatus.passwordChanged) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.editSecurity_PasswordChanged,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    }
  }
}
