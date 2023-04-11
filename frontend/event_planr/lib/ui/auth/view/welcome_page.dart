import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/theme/theme_extension.dart';
import 'package:event_planr/utils/media_query_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyHeight = context.screenBodyHeight;
    final l10 = context.l10n;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: bodyHeight / 2,
              width: double.infinity,
              child: Image.asset(
                'assets/logo/logo.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Text(
              l10.authLetsGetStarted,
              style: context.theme.textTheme.displaySmall!.copyWith(
                color: context.theme.colorScheme.secondary,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 32,
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () => context.push('/auth/login'),
                    style: ElevatedButton.styleFrom(
                      textStyle: context.theme.textTheme.titleLarge,
                      padding: const EdgeInsets.all(16),
                      backgroundColor: context.theme.colorScheme.primary,
                      foregroundColor:
                          context.theme.colorScheme.primaryContainer,
                    ),
                    child: Text(l10.authLogin),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/auth/signup'),
                    style: ElevatedButton.styleFrom(
                      textStyle: context.theme.textTheme.titleLarge,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Text(l10.authSignUp),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(l10.authContinueAsGuest),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
