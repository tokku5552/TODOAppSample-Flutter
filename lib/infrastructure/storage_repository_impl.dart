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
  PersistenceStorageProvider _provider = PersistenceStorageProvider();

  @override
  Future<void> savePersistenceStorage(String key, String value) async {
    await _provider.setString(key, value);
  }

  @override
  Future<String> loadPersistenceStorage(String key) async {
    return _provider.getString(key);
  }

  @override
  Future<bool> isExistKey(String key) async {
    return _provider.containsKey(key);
  }
}

const String VIEW_COMPLETED_ITEMS_KEY = "view_completed_items";
const String VIEW_COMPLETED_ITEMS_KEY_NONE = "NONE";
