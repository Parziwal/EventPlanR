import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_state_handler.dart';
import 'package:event_planr_app/ui/auth/widgets/auth_responsive_frame.dart';
import 'package:event_planr_app/ui/auth/widgets/forgot_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AuthResponsiveFrame(
      desktopHeight: 500,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.auth_ForgotPassword),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: authStateHandler,
              builder: (_, state) => ForgotPasswordForm(
                disabled: state is Loading,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
