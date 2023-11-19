import 'package:event_planr_app/di/injectable.dart';
import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/ui/auth/auth_router.dart';
import 'package:event_planr_app/ui/event/event_router.dart';
import 'package:event_planr_app/ui/organize/organize_router.dart';
import 'package:event_planr_app/ui/shared/page_not_found/view/page_not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PagePaths {
  static String notFound = '/not-found';

  static String signIn = '/auth/signIn';
  static String signUp = '/auth/signUp';
  static String forgotPassword = '/auth/forgotPassword';
  static String confirmSignUp = '/auth/confirmSignUp';
  static String confirmSignUpWithPassword = '/auth/confirmSignUpWithPassword';
  static String confirmForgotPassword = '/auth/confirmForgotPassword';

  static String exploreEvents = '/exploreEvents';
  static String userEvents = '/userEvents';
  static String userChats = '/userChats';
  static String userProfile = '/userProfile';

  static String eventDetails(String eventId) =>
      '/exploreEvents/eventDetails/$eventId';

  static String organizationDetails(String organizationId) =>
      '/exploreEvents/organizationDetails/$organizationId';

  static String eventOrganization(String eventId, String organizationId) =>
      '/exploreEvents/eventDetails/$eventId/organization/$organizationId';

  static String eventNews(String eventId) =>
      '/exploreEvents/eventDetails/$eventId/news';

  static String eventTickets(String eventId) =>
      '/exploreEvents/eventDetails/$eventId/tickets';

  static String eventTicketCheckout(String eventId) =>
      '/exploreEvents/eventDetails/$eventId/tickets/checkout';

  static String userEventTickets(String eventId) =>
      '/userEvents/$eventId/tickets';

  static String userEventTicketOrders(String eventId) =>
      '/userEvents/$eventId/tickets/orders';

  static String userEventInvitation(String eventId) =>
      '/userEvents/$eventId/invitation';

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

  static String organizationEventOrders(String eventId) =>
      '/organizationEventOrders/$eventId';

  static String organizationEventOrderDetails(String eventId, String orderId) =>
      '/organizationEventOrders/$eventId/details/$orderId';

  static String organizationEventCheckIn(String eventId) =>
      '/organizationEventCheckIn/$eventId';

  static String organizationEventCheckInDetails(
    String eventId,
    String soldTicketId,
  ) =>
      '/organizationEventCheckIn/$eventId/details/$soldTicketId';

  static String organizationEventCheckInScanner(String eventId) =>
      '/organizationEventCheckIn/$eventId/scanner';

  static String organizationEventInvitation(String eventId) =>
      '/organizationEventInvitation/$eventId';

  static String organizationEventStatistics(String eventId) =>
      '/organizationEventStatistics/$eventId';
}

final appRouter = GoRouter(
  initialLocation: PagePaths.exploreEvents,
  routes: [
    authRouter,
    eventRouter,
    organizeRouter,
  ],
  redirect: _appRouterRedirect,
  errorBuilder: (context, state) => const PageNotFoundPage(),
);

Future<String?> _appRouterRedirect(
  BuildContext context,
  GoRouterState state,
) async {
  final isAuthenticated = await injector<AuthRepository>().isUserSignedIn;

  if (!isAuthenticated &&
      !state.matchedLocation.startsWith('/auth') &&
      (!state.matchedLocation.startsWith(PagePaths.exploreEvents)) &&
      state.matchedLocation != PagePaths.userEvents &&
      state.matchedLocation != PagePaths.userChats &&
      state.matchedLocation != PagePaths.userProfile) {
    return PagePaths.signIn;
  }

  return null;
}
