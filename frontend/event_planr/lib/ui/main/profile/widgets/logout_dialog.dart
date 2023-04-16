import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/main/profile/profile.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  final profileCubit = context.read<ProfileCubit>();
  final theme = context.theme;
  final l10 = context.l10n;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: profileCubit,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(l10.profileAreYouSureYouWantToLogout),
              actions: [
                TextButton(
                  onPressed: state is ProfileLoading
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.secondary,
                  ),
                  child: Text(l10.profileNo),
                ),
                TextButton(
                  onPressed: state is ProfileLoading
                      ? null
                      : () {
                          context.read<ProfileCubit>().logout();
                        },
                  child: Text(l10.profileYes),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
