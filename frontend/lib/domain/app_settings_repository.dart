import 'package:event_planr_app/data/disk/persistent_store.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:universal_io/io.dart';

@singleton
class AppSettingsRepository {
  AppSettingsRepository({required PersistentStore persistentStore})
      : _persistentStore = persistentStore;

  final PersistentStore _persistentStore;

  Future<void> setTheme(ThemeMode themeMode) async {
    await _persistentStore.save('theme', themeMode.name);
  }

  Future<void> setLanguage(Locale locale) async {
    await _persistentStore.save('languageCode', locale.languageCode);
  }

  ThemeMode getTheme() {
    final theme = _persistentStore.getValue(
      'theme',
      (value) => ThemeMode.values.where((t) => t.name == value).first,
    );

    return theme ?? ThemeMode.system;
  }

  Locale getLanguage() {
    final languageCode =
        _persistentStore.getValue('languageCode', (value) => value);

    if (languageCode != null && languageCode.isNotEmpty) {
      return Locale.fromSubtags(languageCode: languageCode);
    } else {
      var defaultLocal = 'en';
      if (Platform.localeName.split('-')[0] == 'hu') {
        defaultLocal = 'hu';
      }
      return Locale.fromSubtags(languageCode: defaultLocal);
    }
  }
}
