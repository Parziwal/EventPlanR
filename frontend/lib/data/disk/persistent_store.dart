import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class PersistentStore {
  PersistentStore({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  Future<void> save(String key, Object object) async {
    await _sharedPreferences.setString(
      key,
      jsonEncode(object),
    );
  }

  T? getObject<T>(String key, T Function(Map<String, Object?>) fromJson) {
    if (!_sharedPreferences.containsKey(key)) {
      return null;
    }

    final stringValue = _sharedPreferences.getString(key);
    final map = jsonDecode(stringValue!) as Map<String, Object?>;
    return fromJson(map);
  }

  List<T> getList<T>(
    String key,
    List<T> Function(List<Map<String, Object?>>) fromJson,
  ) {
    if (!_sharedPreferences.containsKey(key)) {
      return [];
    }

    final stringValue = _sharedPreferences.getString(key);
    final list = (jsonDecode(stringValue!) as List<dynamic>)
        .map((item) => item as Map<String, Object?>)
        .toList();
    return fromJson(list);
  }

  T? getValue<T>(
    String key,
    T Function(String) transform,
  ) {
    if (!_sharedPreferences.containsKey(key)) {
      return null;
    }

    final stringValue =
        jsonDecode(_sharedPreferences.getString(key)!) as String;
    return transform(stringValue);
  }

  Future<void> remove(String key) {
    return _sharedPreferences.remove(key);
  }
}
