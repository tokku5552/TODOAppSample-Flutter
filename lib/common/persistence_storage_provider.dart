/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceStorageProvider {
  SharedPreferences _prefs;

  Future<void> open() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    final result = await _prefs.setString(key, value);
    return result;
  }

  String getString(String key) {
    final result = _prefs.getString(key);
    return result;
  }

  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
