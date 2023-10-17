import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/user_profile/cubit/user_profile_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/confirmation_dialog.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return BlocListener<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is LoggedOut) {
          context.go(PagePaths.signIn);
        }
      },
      child: EventScaffold(
        title: l10n.userProfile,
        body: ListView(
          children: [
            ListTile(
              title: Text(l10n.userProfile_EditProfile),
              leading: const Icon(Icons.person_outline),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text(l10n.userProfile_Security),
              leading: const Icon(Icons.security_outlined),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text(l10n.userProfile_Notifications),
              leading: const Icon(Icons.notifications_outlined),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text(l10n.userProfile_Appearance),
              leading: const Icon(Icons.style_outlined),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text(l10n.userProfile_ManageEvents),
              leading: const Icon(Icons.event_note_outlined),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.go(PagePaths.userOrganizations),
            ),
            ListTile(
              title: Text(l10n.userProfile_Logout),
              leading: const Icon(Icons.logout_outlined),
              textColor: theme.colorScheme.error,
              iconColor: theme.colorScheme.error,
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    final l10n = context.l10n;

    showConfirmationDialog(
      context,
      message: l10n.userProfile_AreYouSureYouWantToLogout,
    ).then((value) {
      if (value ?? false) {
        context.read<UserProfileCubit>().logout();
      }
    });
  }
}
