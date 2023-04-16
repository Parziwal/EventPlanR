import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:event_planr/ui/auth/utils/auth_extension.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

@override
  Widget build(BuildContext context) {
    final l10 = context.l10n;
    final theme = context.theme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text(l10.authNewPassword),
            backgroundColor: theme.colorScheme.primaryContainer,
            expandedHeight: 120,
          ),
          SliverToBoxAdapter(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: _authListener,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    left: 16,
                    right: 16,
                  ),
                  child: NewPasswordForm(disabled: state is AuthLoading),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _authListener(BuildContext context, AuthState state) {
    final l10 = context.l10n;
    final theme = context.theme;

    if (state is AuthError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.getErrorMessage(l10),
              style: TextStyle(color: theme.colorScheme.error),
            ),
            backgroundColor: theme.colorScheme.errorContainer,
          ),
        );
    } else if (state is AuthSuccess) {
      context.go('/auth/login');
    }
  }
}
