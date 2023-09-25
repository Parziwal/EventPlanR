import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/ui/auth/view/confirm_forgot_password_screen.dart';
import 'package:event_planr_app/ui/auth/view/confirm_sign_up_screen.dart';
import 'package:event_planr_app/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void authStateHandler(BuildContext context, AuthState state) {
  final l10n = context.l10n;
  final theme = context.theme;
  final authCubit = context.read<AuthCubit>();

  state.whenOrNull(
    success: () => context.go(PagePaths.home),
    confirmSignUp: () => Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => BlocProvider<AuthCubit>(
          create: (_) => authCubit,
          child: const ConfirmSignUpScreen(),
        ),
      ),
    ),
    confirmForgotPassword: () => Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => BlocProvider<AuthCubit>(
          create: (_) => authCubit,
          child: const ConfirmForgotPasswordScreen(),
        ),
      ),
    ),
    codeResended: () => ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            l10n.authConfirmCodeResended,
            style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
          ),
          backgroundColor: theme.colorScheme.primaryContainer,
        ),
      ),
    signInNext: () => context.go(PagePaths.signIn),
    error: (errorCode) => ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            l10n.translateError(errorCode),
            style: TextStyle(color: theme.colorScheme.onError),
          ),
          backgroundColor: theme.colorScheme.error,
        ),
      ),
  );
}
