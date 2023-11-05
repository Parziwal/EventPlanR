import 'package:event_planr_app/di/injectable.dart';
import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/models/ticket/organization_ticket.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/ui/auth/view/auth_tab_page.dart';
import 'package:event_planr_app/ui/auth/view/confirm_forgot_password_page.dart';
import 'package:event_planr_app/ui/auth/view/confirm_sign_up_page.dart';
import 'package:event_planr_app/ui/auth/view/forgot_password_page.dart';
import 'package:event_planr_app/ui/event/app_settings/view/app_settings_page.dart';
import 'package:event_planr_app/ui/event/edit_security/cubit/edit_security_cubit.dart';
import 'package:event_planr_app/ui/event/edit_security/view/edit_security_page.dart';
import 'package:event_planr_app/ui/event/edit_user/cubit/edit_user_cubit.dart';
import 'package:event_planr_app/ui/event/edit_user/view/edit_user_page.dart';
import 'package:event_planr_app/ui/event/event_details/cubit/event_details_cubit.dart';
import 'package:event_planr_app/ui/event/event_details/view/event_details_page.dart';
import 'package:event_planr_app/ui/event/event_navbar/cubit/event_navbar_cubit.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_navbar.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/event_news/cubit/event_news_cubit.dart';
import 'package:event_planr_app/ui/event/event_news/view/event_news_page.dart';
import 'package:event_planr_app/ui/event/event_tickets/cubit/event_tickets_cubit.dart';
import 'package:event_planr_app/ui/event/event_tickets/view/event_tickets_page.dart';
import 'package:event_planr_app/ui/event/explore_events/cubit/explore_events_cubit.dart';
import 'package:event_planr_app/ui/event/explore_events/view/explore_events_page.dart';
import 'package:event_planr_app/ui/event/organization_details/cubit/organization_details_cubit.dart';
import 'package:event_planr_app/ui/event/organization_details/view/organiation_details_page.dart';
import 'package:event_planr_app/ui/event/ticket_checkout/cubit/ticket_checkout_cubit.dart';
import 'package:event_planr_app/ui/event/ticket_checkout/view/ticket_checkout_page.dart';
import 'package:event_planr_app/ui/event/user_chats/cubit/user_chats_cubit.dart';
import 'package:event_planr_app/ui/event/user_chats/view/user_chats_page.dart';
import 'package:event_planr_app/ui/event/user_dashboard/view/user_dashboard_page.dart';
import 'package:event_planr_app/ui/event/user_event_tickets/cubit/user_event_tickets_cubit.dart';
import 'package:event_planr_app/ui/event/user_event_tickets/view/user_event_tickets_page.dart';
import 'package:event_planr_app/ui/event/user_events/cubit/user_events_cubit.dart';
import 'package:event_planr_app/ui/event/user_events/view/user_events_page.dart';
import 'package:event_planr_app/ui/event/user_profile/cubit/user_profile_cubit.dart';
import 'package:event_planr_app/ui/event/user_profile/view/user_profile_page.dart';
import 'package:event_planr_app/ui/event/user_ticket_order/cubit/user_ticket_order_cubit.dart';
import 'package:event_planr_app/ui/event/user_ticket_order/view/user_ticket_order_page.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_event/cubit/create_or_edit_event_cubit.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_event/view/create_or_edit_event_page.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_organization/cubit/create_or_edit_organization_cubit.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_organization/view/create_or_edit_organization_page.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_ticket/cubit/create_or_edit_ticket_cubit.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_ticket/view/create_or_edit_ticket_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_details/cubit/organization_event_details_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_details/view/organization_event_details_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_news/cubit/organization_event_news_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_news/view/organization_event_news_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_tickets/cubit/organization_event_tickets_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_tickets/view/organization_event_tickets_page.dart';
import 'package:event_planr_app/ui/organize/organization_events/cubit/organization_events_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_events/view/organization_events_page.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_navbar.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_scaffold.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/cubit/user_organization_details_cubit.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/view/user_organization_details_page.dart';
import 'package:event_planr_app/ui/organize/user_organizations/cubit/user_organizations_cubit.dart';
import 'package:event_planr_app/ui/organize/user_organizations/view/user_organizations_page.dart';
import 'package:event_planr_app/ui/shared/chat_message/cubit/chat_message_cubit.dart';
import 'package:event_planr_app/ui/shared/chat_message/view/chat_message_page.dart';
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
  static String userChats = '/userChats';
  static String userProfile = '/userProfile';

  static String eventDetails(String eventId) =>
      '/exploreEvents/details/$eventId';

  static String eventOrganization(String eventId, String organizationId) =>
      '/exploreEvents/details/$eventId/organization/$organizationId';

  static String eventNews(String eventId) =>
      '/exploreEvents/details/$eventId/news';

  static String eventTickets(String eventId) =>
      '/exploreEvents/details/$eventId/tickets';

  static String eventTicketCheckout(String eventId) =>
      '/exploreEvents/details/$eventId/tickets/checkout';

  static String userEventTickets(String eventId) => '/userEvents/$eventId';

  static String userEventTicketOrders(String eventId) =>
      '/userEvents/$eventId/orders';

  static String userChatMessage(String chatId) => '/userChats/$chatId';

  static String userProfileEdit = '/userProfile/edit';
  static String userProfileSecurity = '/userProfile/security';
  static String userProfileSettings = '/userProfile/settings';

  static String userOrganizations = '/userOrganizations';
  static String userOrganizationCreate = '/userOrganizations/create';
  static String userOrganizationDetails = '/userOrganizationDetails';
  static String userOrganizationEdit = '/userOrganizationDetails/edit';
  static String organizationEvents = '/organizationEvents';
  static String organizationEventsCreate = '/organizationEvents/create';

  static String organizationEventDetails(String eventId) =>
      '/organizationEventDetails/$eventId';

  static String organizationEventEdit(String eventId) =>
      '/organizationEventDetails/$eventId/edit';

  static String organizationEventTickets(String eventId) =>
      '/organizationEventTickets/$eventId';

  static String organizationEventTicketCreate(String eventId) =>
      '/organizationEventTickets/$eventId/create';

  static String organizationEventTicketEdit(String eventId) =>
      '/organizationEventTickets/$eventId/edit';

  static String organizationEventNews(String eventId) =>
      '/organizationEventNews/$eventId';

  static String organizationEventChat(String chatId) =>
      '/organizationEventChat/$chatId';
}

final appRouter = GoRouter(
  initialLocation: PagePaths.userDashboard,
  routes: [
    BlocRoute<AuthCubit>(
      path: PagePaths.signIn,
      builder: (_) => const AuthTabPage(),
      init: (cubit, _) => cubit.autoLogin(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.signUp,
      builder: (_) => const AuthTabPage(),
      init: (cubit, _) => cubit.autoLogin(),
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
          child: EventNavbar(
            key: state.pageKey,
            child: child,
          ),
        );
      },
      routes: [
        BlocRoute<AuthCubit>(
          path: PagePaths.userDashboard,
          builder: (_) => const UserDashboardPage(),
        ),
        BlocRoute<ExploreEventsCubit>(
          path: PagePaths.exploreEvents,
          builder: (state) => const ExploreEventsPage(),
          routes: [
            BlocRoute<EventDetailsCubit>(
              path: 'details/:eventId',
              builder: (state) => const EventDetailsPage(),
              init: (cubit, state) =>
                  cubit.loadEventDetails(state.pathParameters['eventId']!),
              routes: [
                BlocRoute<OrganizationDetailsCubit>(
                  path: 'organization/:organizationId',
                  builder: (state) => const OrganizationDetailsPage(),
                  init: (cubit, state) => cubit.loadOrganizationDetails(
                    state.pathParameters['organizationId']!,
                  ),
                ),
                BlocRoute<EventNewsCubit>(
                  path: 'news',
                  builder: (state) => const EventNewsPage(),
                ),
                BlocRoute<EventTicketsCubit>(
                  path: 'tickets',
                  builder: (state) => const EventTicketsPage(),
                  init: (cubit, state) =>
                      cubit.loadEventTickets(state.pathParameters['eventId']!),
                  routes: [
                    BlocRoute<TicketCheckoutCubit>(
                      path: 'checkout',
                      builder: (state) => const TicketCheckoutPage(),
                      init: (cubit, state) => cubit.loadReservedTickets(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        BlocRoute<UserEventsCubit>(
          path: PagePaths.userEvents,
          builder: (state) => const UserEventsPage(),
          routes: [
            BlocRoute<UserEventTicketsCubit>(
              path: ':eventId',
              builder: (state) => const UserEventTicketsPage(),
              init: (cubit, state) =>
                  cubit.loadUserEventTickets(state.pathParameters['eventId']!),
              routes: [
                BlocRoute<UserTicketOrderCubit>(
                  path: 'orders',
                  builder: (state) => const UserTicketOrderPage(),
                  init: (cubit, state) => cubit
                      .loadUserEventOrders(state.pathParameters['eventId']!),
                ),
              ],
            ),
          ],
        ),
        BlocRoute<UserChatsCubit>(
          path: PagePaths.userChats,
          builder: (state) => const UserChatsPage(),
          routes: [
            BlocRoute<ChatMessageCubit>(
              path: ':chatId',
              builder: (state) => ChatMessagePage(
                frame: (title, child) => EventScaffold(
                  title: title,
                  body: child,
                ),
              ),
              init: (cubit, state) =>
                  cubit.loadMessages(state.pathParameters['chatId']!),
            ),
          ],
        ),
        BlocRoute<UserProfileCubit>(
          path: PagePaths.userProfile,
          builder: (state) => const UserProfilePage(),
          routes: [
            BlocRoute<EditUserCubit>(
              path: 'edit',
              builder: (state) => const EditUserPage(),
              init: (cubit, state) => cubit.loadUserData(),
            ),
            BlocRoute<EditSecurityCubit>(
              path: 'security',
              builder: (state) => const EditSecurityPage(),
            ),
            GoRoute(
              path: 'settings',
              builder: (context, state) => const AppSettingsPage(),
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          key: state.pageKey,
          create: (_) => injector<OrganizeNavbarCubit>()..loadUserData(),
          child: OrganizeNavbar(
            key: state.pageKey,
            child: child,
          ),
        );
      },
      routes: [
        BlocRoute<UserOrganizationsCubit>(
          path: PagePaths.userOrganizations,
          builder: (state) => const UserOrganizationsPage(),
          init: (cubit, _) => cubit.loadUserOrganizations(),
          routes: [
            BlocRoute<CreateOrEditOrganizationCubit>(
              path: 'create',
              builder: (state) => const CreateOrEditOrganizationPage(),
            ),
          ],
        ),
        BlocRoute<UserOrganizationDetailsCubit>(
          path: PagePaths.userOrganizationDetails,
          builder: (state) => const UserOrganizationDetailsPage(),
          init: (cubit, _) => cubit.loadUserOrganizationDetails(),
          routes: [
            BlocRoute<CreateOrEditOrganizationCubit>(
              path: 'edit',
              builder: (state) => const CreateOrEditOrganizationPage(),
              init: (cubit, _) => cubit.loadOrganizationDetailsForEdit(),
            ),
          ],
        ),
        BlocRoute<OrganizationEventsCubit>(
          path: PagePaths.organizationEvents,
          builder: (state) => const OrganizationEventsPage(),
          routes: [
            BlocRoute<CreateOrEditEventCubit>(
              path: 'create',
              builder: (state) => const CreateOrEditEventPage(),
            ),
          ],
        ),
        BlocRoute<OrganizationEventDetailsCubit>(
          path: PagePaths.organizationEventDetails(':eventId'),
          builder: (state) => const OrganizationEventDetailsPage(),
          init: (cubit, state) =>
              cubit.loadEventDetails(state.pathParameters['eventId']!),
          routes: [
            BlocRoute<CreateOrEditEventCubit>(
              path: 'edit',
              builder: (state) => const CreateOrEditEventPage(),
              init: (cubit, state) => cubit.loadEventDetailsForEdit(
                state.pathParameters['eventId']!,
              ),
            ),
          ],
        ),
        BlocRoute<OrganizationEventTicketsCubit>(
          path: PagePaths.organizationEventTickets(':eventId'),
          builder: (state) => const OrganizationEventTicketsPage(),
          init: (cubit, state) =>
              cubit.loadEventTickets(state.pathParameters['eventId']!),
          routes: [
            BlocRoute<CreateOrEditTicketCubit>(
              path: 'create',
              builder: (state) => const CreateOrEditTicketPage(),
            ),
            BlocRoute<CreateOrEditTicketCubit>(
              path: 'edit',
              builder: (state) => const CreateOrEditTicketPage(),
              init: (cubit, state) =>
                  cubit.loadTicketForEdit(state.extra! as OrganizationTicket),
            ),
          ],
        ),
        BlocRoute<OrganizationEventNewsCubit>(
          path: PagePaths.organizationEventNews(':eventId'),
          builder: (state) => const OrganizationEventNewsPage(),
        ),
        BlocRoute<ChatMessageCubit>(
          path: PagePaths.organizationEventChat(':chatId'),
          builder: (state) => ChatMessagePage(
            frame: (title, child) => OrganizeScaffold(
              title: title,
              body: child,
            ),
          ),
          init: (cubit, state) => cubit.loadMessages(
            state.pathParameters['chatId']!,
            isOrganizationView: true,
          ),
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
