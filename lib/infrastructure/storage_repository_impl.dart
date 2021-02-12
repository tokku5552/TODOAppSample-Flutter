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
  final PersistenceStorageProvider _instance =
      PersistenceStorageProvider.instance;

  @override
  Future<void> savePersistenceStorage(String key, String value) async {
    final pref = await _instance.prefs;
    await pref.setString(key, value);
  }

  @override
  Future<String> loadPersistenceStorage(String key) async {
    final pref = await _instance.prefs;
    return pref.getString(key);
  }

  @override
  Future<bool> isExistKey(String key) async {
    final pref = await _instance.prefs;
    return pref.containsKey(key);
  }
}
