import 'package:event_planr_app/l10n/l10n.dart';

extension ErrorLocalizationsX on AppLocalizations {
  String translateEnums(String enumName) {
    return switch(enumName) {
      'conference' => '',
      'tradeShows' => '',
      'workshop' => '',
      'networking' => '',
      'socialGathering' => '',
      'entertainment' => '',
      'competition' => '',
      'sport' => '',
      'cultural' => '',
      'travel' => '',
      'other' => '',
      _ => ''
    };
  }
}
