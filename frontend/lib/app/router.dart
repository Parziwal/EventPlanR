import 'package:event_planr_app/di/injectable.dart';
import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/ui/auth/view/auth_tab_page.dart';
import 'package:event_planr_app/ui/auth/view/forgot_password_page.dart';
import 'package:event_planr_app/ui/event/event_navbar/cubit/event_navbar_cubit.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_navbar.dart';
import 'package:event_planr_app/ui/event/explore_events/view/explore_events_page.dart';
import 'package:event_planr_app/ui/event/user_dashboard/view/user_dashboard_page.dart';
import 'package:event_planr_app/ui/event/user_events/view/user_events_page.dart';
import 'package:event_planr_app/ui/event/user_messages/view/user_messages_page.dart';
import 'package:event_planr_app/ui/event/user_profile/cubit/user_profile_cubit.dart';
import 'package:event_planr_app/ui/event/user_profile/view/user_profile_page.dart';
import 'package:event_planr_app/ui/organize/create_organization/cubit/create_organization_cubit.dart';
import 'package:event_planr_app/ui/organize/create_organization/view/create_organization_page.dart';
import 'package:event_planr_app/ui/organize/edit_organization/cubit/edit_organization_cubit.dart';
import 'package:event_planr_app/ui/organize/edit_organization/view/edit_organization_page.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_navbar.dart';
import 'package:event_planr_app/ui/organize/user_organizations/cubit/user_organizations_cubit.dart';
import 'package:event_planr_app/ui/organize/user_organizations/view/user_organizations_page.dart';
import 'package:event_planr_app/utils/bloc_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PagePaths {
  static String signIn = '/auth/signIn';
  static String signUp = '/auth/signUp';
  static String forgotPassword = '/auth/forgotPassword';
  static String userDashboard = '/userDashboard';
  static String exploreEvents = '/exploreEvents';
  static String userEvents = '/userEvents';
  static String userMessages = '/userMessages';
  static String userProfile = '/userProfile';

  static String userOrganizations = '/userOrganizations';
  static String userOrganizationsCreate = '/userOrganizations/create';

  static String userOrganizationsEdit(String organizationId) =>
      '/userOrganizations/edit/$organizationId';
}

final appRouter = GoRouter(
  initialLocation: PagePaths.userDashboard,
  routes: [
    BlocRoute<AuthCubit>(
      path: PagePaths.signIn,
      builder: (_) => const AuthTabPage(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.signUp,
      builder: (_) => const AuthTabPage(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.forgotPassword,
      builder: (_) => const ForgotPasswordPage(),
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BlocProvider(
          create: (_) => injector<EventNavbarCubit>(),
          child: EventNavbar(child: child),
        );
      },
      routes: [
        BlocRoute<AuthCubit>(
          path: PagePaths.userDashboard,
          builder: (_) => const UserDashboardPage(),
        ),
        BlocRoute<AuthCubit>(
          path: PagePaths.exploreEvents,
          builder: (state) => const ExploreEventsPage(),
        ),
        BlocRoute<AuthCubit>(
          path: PagePaths.userEvents,
          builder: (state) => const UserEventsPage(),
        ),
        BlocRoute<AuthCubit>(
          path: PagePaths.userMessages,
          builder: (state) => const UserMessagesPage(),
        ),
        BlocRoute<UserProfileCubit>(
          path: PagePaths.userProfile,
          builder: (state) => const UserProfilePage(),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (_) => injector<OrganizeNavbarCubit>(),
          child: OrganizeNavbar(
            child: child,
          ),
        );
      },
      routes: [
        BlocRoute<UserOrganizationsCubit>(
          path: PagePaths.userOrganizations,
          builder: (state) => const UserOrganizationsPage(),
          routes: [
            BlocRoute<CreateOrganizationCubit>(
              path: 'create',
              builder: (state) => const CreateOrganizationPage(),
            ),
            BlocRoute<EditOrganizationCubit>(
              path: 'edit/:organizationId',
              builder: (state) => const EditOrganizationPage(),
              cubit: (state, cubit) => cubit
                ..loadOrganization(state.pathParameters['organizationId']!),
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: _appRouterRedirect,
);

Future<String?> _appRouterRedirect(
  BuildContext context,
  GoRouterState state,
) async {
  final isAuthenticated = await injector<AuthRepository>().isUserSignedIn();
  if (!isAuthenticated && !state.matchedLocation.startsWith('/auth')) {
    return PagePaths.signIn;
  }
  return null;
}
