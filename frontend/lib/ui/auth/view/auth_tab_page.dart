import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/ui/auth/view/sign_in_tab.dart';
import 'package:event_planr_app/ui/auth/view/sign_up_tab.dart';
import 'package:event_planr_app/ui/auth/widgets/auth_responsive_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthTabPage extends StatefulWidget {
  const AuthTabPage({super.key});

  @override
  State<AuthTabPage> createState() => _AuthTabPageState();
}

class _AuthTabPageState extends State<AuthTabPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().autoLogin();

    final l10n = context.l10n;
    final currentPath = GoRouterState.of(context).path;
    _tabController.animateTo(currentPath == PagePaths.signIn ? 0 : 1);

    return AuthResponsiveFrame(
      desktopHeight: 500,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 5,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: l10n.authSignIn),
              Tab(text: l10n.authSignUp),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            SignInTab(),
            SignUpTab(),
          ],
        ),
      ),
    );
  }
}
