/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceStorageProvider {
  PersistenceStorageProvider._();

  static final PersistenceStorageProvider instance =
      PersistenceStorageProvider._();
  SharedPreferences _prefs;

  Future<SharedPreferences> get prefs async {
    return _prefs ??= await initSharedPreferences();
  }

  Future<SharedPreferences> initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
