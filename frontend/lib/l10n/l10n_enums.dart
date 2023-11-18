import 'package:event_planr_app/l10n/l10n.dart';

extension ErrorLocalizationsX on AppLocalizations {
  String translateEnums(String enumName) {
    return switch (enumName) {
      'conference' => enum_Conference,
      'tradeShows' => enum_TradeShows,
      'workshop' => enum_Workshop,
      'networking' => enum_Networking,
      'socialGathering' => enum_SocialGathering,
      'community' => enum_Community,
      'entertainment' => enum_Entertainment,
      'competition' => enum_Competition,
      'sport' => enum_Sport,
      'cultural' => enum_Cultural,
      'travel' => enum_Travel,
      'other' => enum_Other,
      'huf' => enum_HUF,
      'eur' => enum_EUR,
      'usd' => enum_USD,
      'gbp' => enum_GBP,
      'organization.view' => enum_OrganizationView,
      'organization.manage' => enum_OrganizationManage,
      'organization-event.view' => enum_OrganizationEventView,
      'organization-event.manage' => enum_OrganizationEventManage,
      'event-ticket.view' => enum_EventTicketView,
      'event-ticket.manage' => enum_EventTicketManage,
      'news-post.view' => enum_NewsPostView,
      'news-post.manage' => enum_NewsPostManage,
      'user-check-in' => enum_UserCheckIn,
      'ascending' => enum_Ascending,
      'descending' => enum_Descending,
      'name' => enum_Name,
      'fromDate' => enum_FromDate,
      'venue' => enum_Venue,
      'organizationName' => enum_OrganizationName,
      'km5' => enum_km5,
      'km10' => enum_km10,
      'km20' => enum_km20,
      'km50' => enum_km50,
      'km100' => enum_km100,
      'hu' => enum_hu,
      'en' => enum_en,
      'light' => enum_light,
      'dark' => enum_dark,
      'system' => enum_system,
      'accept' => enum_Accept,
      'deny' => enum_Deny,
      'pending' => enum_Pending,
      _ => enumName,
    };
  }
}
