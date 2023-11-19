import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/di/injectable.dart';
import 'package:event_planr_app/ui/event/app_settings/view/app_settings_page.dart';
import 'package:event_planr_app/ui/event/edit_security/cubit/edit_security_cubit.dart';
import 'package:event_planr_app/ui/event/edit_security/view/edit_security_page.dart';
import 'package:event_planr_app/ui/event/edit_user/cubit/edit_user_cubit.dart';
import 'package:event_planr_app/ui/event/edit_user/view/edit_user_page.dart';
import 'package:event_planr_app/ui/event/event_details/cubit/event_details_cubit.dart';
import 'package:event_planr_app/ui/event/event_details/view/event_details_page.dart';
import 'package:event_planr_app/ui/event/event_navbar/cubit/event_navbar_cubit.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/event_news/cubit/event_news_cubit.dart';
import 'package:event_planr_app/ui/event/event_news/view/event_news_page.dart';
import 'package:event_planr_app/ui/event/event_tickets/cubit/event_tickets_cubit.dart';
import 'package:event_planr_app/ui/event/event_tickets/view/event_tickets_page.dart';
import 'package:event_planr_app/ui/event/explore_events/cubit/explore_events_cubit.dart';
import 'package:event_planr_app/ui/event/explore_events/view/explore_events_page.dart';
import 'package:event_planr_app/ui/event/organization_details/cubit/organization_details_cubit.dart';
import 'package:event_planr_app/ui/event/organization_details/view/organization_details_page.dart';
import 'package:event_planr_app/ui/event/ticket_checkout/cubit/ticket_checkout_cubit.dart';
import 'package:event_planr_app/ui/event/ticket_checkout/view/ticket_checkout_page.dart';
import 'package:event_planr_app/ui/event/user_chats/cubit/user_chats_cubit.dart';
import 'package:event_planr_app/ui/event/user_chats/view/user_chats_page.dart';
import 'package:event_planr_app/ui/event/user_event_tickets/cubit/user_event_tickets_cubit.dart';
import 'package:event_planr_app/ui/event/user_event_tickets/view/user_event_tickets_page.dart';
import 'package:event_planr_app/ui/event/user_events/cubit/user_events_cubit.dart';
import 'package:event_planr_app/ui/event/user_events/view/user_events_page.dart';
import 'package:event_planr_app/ui/event/user_invitation/cubit/user_invitation_cubit.dart';
import 'package:event_planr_app/ui/event/user_invitation/view/user_invitation_page.dart';
import 'package:event_planr_app/ui/event/user_profile/cubit/user_profile_cubit.dart';
import 'package:event_planr_app/ui/event/user_profile/view/user_profile_page.dart';
import 'package:event_planr_app/ui/event/user_ticket_order/cubit/user_ticket_order_cubit.dart';
import 'package:event_planr_app/ui/event/user_ticket_order/view/user_ticket_order_page.dart';
import 'package:event_planr_app/ui/shared/chat_message/cubit/chat_message_cubit.dart';
import 'package:event_planr_app/ui/shared/chat_message/view/chat_message_page.dart';
import 'package:event_planr_app/utils/bloc_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final eventRouter = ShellRoute(
  builder: (context, state, child) {
    return BlocProvider(
      key: state.pageKey,
      create: (_) => injector<EventNavbarCubit>()..loadUserData(),
      child: child,
    );
  },
  routes: [
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
          path: ':eventId/tickets',
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
        BlocRoute<UserInvitationCubit>(
          path: ':eventId/invitation',
          builder: (state) => const UserInvitationPage(),
          init: (cubit, state) =>
              cubit.loadInvitation(state.pathParameters['eventId']!),
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
);
