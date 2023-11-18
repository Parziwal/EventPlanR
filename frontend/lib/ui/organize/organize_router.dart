import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/di/injectable.dart';
import 'package:event_planr_app/domain/models/ticket/organization_ticket.dart';
import 'package:event_planr_app/ui/organize/check_in_ticket_scanner/cubit/check_in_ticket_scanner_cubit.dart';
import 'package:event_planr_app/ui/organize/check_in_ticket_scanner/view/check_in_ticket_scanner_page.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_event/cubit/create_or_edit_event_cubit.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_event/view/create_or_edit_event_page.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_organization/cubit/create_or_edit_organization_cubit.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_organization/view/create_or_edit_organization_page.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_ticket/cubit/create_or_edit_ticket_cubit.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_ticket/view/create_or_edit_ticket_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_check_in/cubit/organization_event_check_in_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_check_in/view/organization_event_check_in_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_check_in_details/cubit/organization_event_check_in_details_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_check_in_details/view/organization_event_check_in_details_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_details/cubit/organization_event_details_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_details/view/organization_event_details_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_invitation/cubit/organization_event_invitation_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_invitation/view/organization_event_invitation_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_news/cubit/organization_event_news_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_news/view/organization_event_news_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_order_details/cubit/organization_event_order_details_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_order_details/view/organization_event_order_details_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_orders/cubit/organization_event_orders_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_orders/view/organization_event_orders_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_statistics/cubit/organization_event_statistics_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_statistics/view/organization_event_statistics_page.dart';
import 'package:event_planr_app/ui/organize/organization_event_tickets/cubit/organization_event_tickets_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_tickets/view/organization_event_tickets_page.dart';
import 'package:event_planr_app/ui/organize/organization_events/cubit/organization_events_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_events/view/organization_events_page.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/cubit/user_organization_details_cubit.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/view/user_organization_details_page.dart';
import 'package:event_planr_app/ui/organize/user_organizations/cubit/user_organizations_cubit.dart';
import 'package:event_planr_app/ui/organize/user_organizations/view/user_organizations_page.dart';
import 'package:event_planr_app/ui/shared/chat_message/cubit/chat_message_cubit.dart';
import 'package:event_planr_app/ui/shared/chat_message/view/chat_message_page.dart';
import 'package:event_planr_app/utils/bloc_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final organizeRouter = ShellRoute(
  builder: (context, state, child) {
    return BlocProvider(
      key: state.pageKey,
      create: (_) => injector<OrganizeNavbarCubit>()..loadUserData(),
      child: child,
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
    BlocRoute<OrganizationEventOrdersCubit>(
      path: PagePaths.organizationEventOrders(':eventId'),
      builder: (state) => const OrganizationEventOrdersPage(),
      routes: [
        BlocRoute<OrganizationEventOrderDetailsCubit>(
          path: 'details/:orderId',
          builder: (state) => const OrganizationEventOrderDetailsPage(),
          init: (cubit, state) =>
              cubit.loadEventOrderDetails(state.pathParameters['orderId']!),
        ),
      ],
    ),
    BlocRoute<OrganizationEventCheckInCubit>(
      path: PagePaths.organizationEventCheckIn(':eventId'),
      builder: (state) => const OrganizationEventCheckInPage(),
      routes: [
        BlocRoute<OrganizationEventCheckInDetailsCubit>(
          path: 'details/:soldTicketId',
          builder: (state) => const OrganizationEventCheckInDetailsPage(),
          init: (cubit, state) => cubit.loadCheckInTicketDetails(
            state.pathParameters['soldTicketId']!,
          ),
        ),
        BlocRoute<CheckInTicketScannerCubit>(
          path: 'scanner',
          builder: (state) => const CheckInTicketScannerPage(),
        ),
      ],
    ),
    BlocRoute<OrganizationEventInvitationCubit>(
      path: PagePaths.organizationEventInvitation(':eventId'),
      builder: (state) => const OrganizationEventInvitationPage(),
    ),
    BlocRoute<OrganizationEventStatisticsCubit>(
      path: PagePaths.organizationEventStatistics(':eventId'),
      builder: (state) => const OrganizationEventStatisticsPage(),
      init: (cubit, state) =>
          cubit.loadEventStatistics(state.pathParameters['eventId']!),
    ),
  ],
);
