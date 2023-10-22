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
      _ => enumName,
    };
  }
}
