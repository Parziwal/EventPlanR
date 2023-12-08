import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/event/edit_user/cubit/edit_user_cubit.dart';
import 'package:event_planr_app/ui/event/edit_user/widgets/confirm_email_change_modal.dart';
import 'package:event_planr_app/ui/event/edit_user/widgets/edit_user_form.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/image_picker_item.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/max_width_box.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EventScaffold(
      title: l10n.editUser,
      body: BlocConsumer<EditUserCubit, EditUserState>(
        listener: _stateListener,
        builder: (context, state) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: MaxWidthBox(
            maxWidth: 600,
            child: Column(
              children: [
                ImagePickerItem(
                  imagePicked: (file) =>
                      context.read<EditUserCubit>().uploadProfileImage(file),
                  imageUrl: state.user?.picture,
                ),
                const SizedBox(height: 16),
                EditUserForm(
                  key: ValueKey(state.status),
                  disabled: state.status == EditUserStatus.loading,
                  user: state.user,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    EditUserState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == EditUserStatus.error) {
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
    } else if (state.status == EditUserStatus.userEdited) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.editUser_ProfileUpdated,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      if (state.emailConfirmationNeeded) {
        showConfirmEmailChangeModal(context);
      }
    } else if (state.status == EditUserStatus.codeResended) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.editUser_CodeResended,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    } else if (state.status == EditUserStatus.emailConfirmed) {
      context.pop();
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.editUser_EmailConfirmed,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    }
  }
}
