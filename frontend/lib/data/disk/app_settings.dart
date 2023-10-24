import 'dart:convert';

import 'package:event_planr_app/domain/models/event/organization_event.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AppSettings {
  AppSettings({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const String _organizationSelectedEventKey =
      'OrganizationSelectedEvent';

  Future<void> setOrganizationSelectedEvent(OrganizationEvent event) async {
    await _sharedPreferences.setString(
      _organizationSelectedEventKey,
      jsonEncode(event.toJson()),
    );
  }

  OrganizationEvent? getOrganizationSelectedEvent() {
    if (!_sharedPreferences.containsKey(_organizationSelectedEventKey)) {
      return null;
    }

    final selectedEventValue = _sharedPreferences.getString(
      _organizationSelectedEventKey,
    );

    final selectedEvent =
        jsonDecode(selectedEventValue!) as Map<String, Object?>;
    return OrganizationEvent.fromJson(selectedEvent);
  }
}
