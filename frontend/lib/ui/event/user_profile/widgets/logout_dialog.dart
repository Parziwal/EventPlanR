import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/user_profile/cubit/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  final profileCubit = context.read<UserProfileCubit>();

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: profileCubit,
        child: _logoutDialog(context),
      );
    },
  );
}

Widget _logoutDialog(BuildContext context) {
  final l10n = context.l10n;

  return BlocBuilder<UserProfileCubit, UserProfileState>(
    builder: (context, state) {
      return AlertDialog(
        title: Text(l10n.userProfile_AreYouSureYouWantToLogout),
        actions: [
          FilledButton(
            onPressed: state is Loading
                ? null
                : () => context.read<UserProfileCubit>().logout(),
            child: Text(l10n.yes),
          ),
          FilledButton.tonal(
            onPressed: state is Loading
                ? null
                : () => Navigator.of(context).pop(),
            child: Text(l10n.no),
          ),
        ],
      );
    },
  );
}
