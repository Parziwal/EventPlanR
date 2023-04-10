import 'package:beamer/beamer.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:flutter/material.dart';

class AuthLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        '/auth',
        '/auth/login',
        '/auth/signup',
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('welcome'),
          title: 'Welcome',
          child: WelcomePage(),
        ),
        if (state.uri.pathSegments.contains('login'))
          const BeamPage(
            key: ValueKey('login'),
            title: 'Login',
            child: LoginPage(),
          ),
        if (state.uri.pathSegments.contains('signup'))
          const BeamPage(
            key: ValueKey('signup'),
            title: 'Sign up',
            child: SignUpPage(),
          ),
      ];
}
