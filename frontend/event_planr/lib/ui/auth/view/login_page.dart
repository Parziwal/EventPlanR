import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:event_planr/utils/theme_extension.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text(l10.authLoginToYourAccount),
            backgroundColor: context.theme.colorScheme.primaryContainer,
            expandedHeight: 120,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32,
                left: 16,
                right: 16,
              ),
              child: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}
