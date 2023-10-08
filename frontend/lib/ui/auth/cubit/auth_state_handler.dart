import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void authStateHandler(BuildContext context, AuthState state) {
  final l10n = context.l10n;
  final theme = context.theme;

  switch (state) {
    case Success():
      context.go(PagePaths.userDashboard);
    case ConfirmSignUp():
      context.push(PagePaths.confirmSignUp);
    case ConfirmForgotPassword():
      context.push(PagePaths.confirmForgotPassword);
    case CodeResended():
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.authConfirmCodeResended,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    case SignInNext():
      context.go(PagePaths.signIn);
    case Error(:final errorCode):
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(errorCode),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    default:
  }
}
