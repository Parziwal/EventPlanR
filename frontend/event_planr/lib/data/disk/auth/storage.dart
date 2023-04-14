import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class Storage extends CognitoStorage {
  Storage({required SharedPreferences preferences})
      : _preferences = preferences;

  final SharedPreferences _preferences;

  @override
  Future<dynamic> getItem(String key) async {
    return _preferences.getString(key);
  }

  @override
  Future<dynamic> setItem(String key, dynamic value) async {
    await _preferences.setString(key, json.encode(value));
    return getItem(key);
  }

  @override
  Future<dynamic> removeItem(String key) async {
    final item = await getItem(key);
    if (item != null) {
      await _preferences.remove(key);
      return item;
    }
    return null;
  }

  @override
  Future<void> clear() async {
    await _preferences.clear();
  }
}
