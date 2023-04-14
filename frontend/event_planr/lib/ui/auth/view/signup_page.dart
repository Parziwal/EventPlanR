import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;
    final theme = context.theme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text(l10.authCreateYourAccount),
            backgroundColor: theme.colorScheme.primaryContainer,
            expandedHeight: 120,
          ),
          SliverToBoxAdapter(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                        backgroundColor: theme.colorScheme.onError,
                      ),
                    );
                } else if (state is AuthConfirm) {
                  context.go('/auth/confirm');
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    left: 16,
                    right: 16,
                  ),
                  child: SignUpForm(disable: state is AuthLoading),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
