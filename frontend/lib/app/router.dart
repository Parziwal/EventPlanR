import 'package:event_planr_app/di/injectable.dart';
import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/ui/auth/view/auth_tab_page.dart';
import 'package:event_planr_app/ui/auth/view/confirm_forgot_password_page.dart';
import 'package:event_planr_app/ui/auth/view/confirm_sign_up_page.dart';
import 'package:event_planr_app/ui/auth/view/forgot_password_page.dart';
import 'package:event_planr_app/ui/event/event_navbar/cubit/event_navbar_cubit.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_navbar.dart';
import 'package:event_planr_app/ui/event/explore_events/view/explore_events_page.dart';
import 'package:event_planr_app/ui/event/user_dashboard/view/user_dashboard_page.dart';
import 'package:event_planr_app/ui/event/user_events/view/user_events_page.dart';
import 'package:event_planr_app/ui/event/user_messages/view/user_messages_page.dart';
import 'package:event_planr_app/ui/event/user_profile/cubit/user_profile_cubit.dart';
import 'package:event_planr_app/ui/event/user_profile/view/user_profile_page.dart';
import 'package:event_planr_app/ui/organize/create_event/view/create_event_page.dart';
import 'package:event_planr_app/ui/organize/create_organization/cubit/create_organization_cubit.dart';
import 'package:event_planr_app/ui/organize/create_organization/view/create_organization_page.dart';
import 'package:event_planr_app/ui/organize/edit_organization/cubit/edit_organization_cubit.dart';
import 'package:event_planr_app/ui/organize/edit_organization/view/edit_organization_page.dart';
import 'package:event_planr_app/ui/organize/organization_events/cubit/organization_events_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_events/view/organization_events_page.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_navbar.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/cubit/user_organization_details_cubit.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/view/user_organization_details_page.dart';
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
  static String confirmSignUp = '/auth/confirmSignUp';
  static String confirmForgotPassword = '/auth/confirmForgotPassword';

  static String userDashboard = '/userDashboard';
  static String exploreEvents = '/exploreEvents';
  static String userEvents = '/userEvents';
  static String userMessages = '/userMessages';
  static String userProfile = '/userProfile';

  static String userOrganizations = '/userOrganizations';
  static String userOrganizationDetails = '/userOrganizationsDetails';
  static String userOrganizationsCreate = '/userOrganizations/create';

  static String userOrganizationsDetailsEdit(String organizationId) =>
      '/userOrganizationsDetails/edit/$organizationId';

  static String organizationEvents(String organizationId) =>
      '/organizationsEvents/$organizationId';
}

final appRouter = GoRouter(
  initialLocation: PagePaths.userDashboard,
  routes: [
    BlocRoute<AuthCubit>(
      path: PagePaths.signIn,
      builder: (_) => const AuthTabPage(),
      init: (cubit, _) => cubit..autoLogin(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.signUp,
      builder: (_) => const AuthTabPage(),
      init: (cubit, _) => cubit..autoLogin(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.forgotPassword,
      builder: (_) => const ForgotPasswordPage(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.confirmSignUp,
      builder: (_) => const ConfirmSignUpPage(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.confirmForgotPassword,
      builder: (_) => const ConfirmForgotPasswordPage(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          key: state.pageKey,
          create: (_) => injector<EventNavbarCubit>()..loadUserData(),
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
          key: state.pageKey,
          create: (_) => injector<OrganizeNavbarCubit>()..loadUserData(),
          child: OrganizeNavbar(
            child: child,
          ),
        );
      },
      routes: [
        BlocRoute<UserOrganizationsCubit>(
          path: PagePaths.userOrganizations,
          builder: (state) => const UserOrganizationsPage(),
          init: (cubit, _) => cubit..loadUserOrganization(),
          routes: [
            BlocRoute<CreateOrganizationCubit>(
              path: 'create',
              builder: (state) => const CreateOrganizationPage(),
            ),
          ],
        ),
        BlocRoute<UserOrganizationDetailsCubit>(
          path: PagePaths.userOrganizationDetails,
          builder: (state) => const UserOrganizationDetailsPage(),
          routes: [
            BlocRoute<EditOrganizationCubit>(
              path: 'edit/:organizationId',
              builder: (state) => const EditOrganizationPage(),
              init: (cubit, state) =>
              cubit..loadOrganization(state.pathParameters['organizationId']!),
            ),
          ],
        ),
        BlocRoute<OrganizationEventsCubit>(
          path: PagePaths.organizationEvents(':organizationId'),
          builder: (state) => const CreateEventPage(),
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
  final isAuthenticated = await injector<AuthRepository>().isUserSignedIn;
  if (!isAuthenticated && !state.matchedLocation.startsWith('/auth')) {
    return PagePaths.signIn;
  }
  return null;
}
