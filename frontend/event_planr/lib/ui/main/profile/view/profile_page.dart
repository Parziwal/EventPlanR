import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/main/profile/profile.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10 = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10.profile),
        elevation: 2,
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLogoutComplete) {
            context.go('/auth');
          }
        },
        child: ListView(
          children: [
            ListTile(
              title: Text(l10.profileLogout),
              leading: const Icon(Icons.logout_outlined),
              onTap: () => showLogoutDialog(context),
              textColor: theme.colorScheme.error,
              iconColor: theme.colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
