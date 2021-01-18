/*
 * Copyright (c) 2020 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
import 'package:todo_app_sample_flutter/common/persistence_storage_provider.dart';
import 'package:todo_app_sample_flutter/domain/storage_repository.dart';

class StorageRepositoryImpl implements StorageRepository {
  static PersistenceStorageProvider instance =
      PersistenceStorageProvider.instance;

  static void savePersistenceStorage(String key, String value) async {
    final pref = await instance.prefs;
    await pref.setString(key, value);
  }

  static Future<String> loadPersistenceStorage(String key) async {
    final pref = await instance.prefs;
    return pref.getString(key);
  }

  static Future<bool> isExistKey(String key) async {
    final pref = await instance.prefs;
    return pref.containsKey(key);
  }
}

const String VIEW_COMPLETED_ITEMS_KEY = "view_completed_items";
const String VIEW_COMPLETED_ITEMS_KEY_NONE = "NONE";
