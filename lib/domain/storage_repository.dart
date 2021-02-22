/*
 * Copyright (c) 2021 tokku5552
 *
 * This software is released under the MIT License.
 * https://opensource.org/licenses/mit-license.php
 *
 */
abstract class StorageRepository {
  Future<void> savePersistenceStorage(String key, String value);
  Future<String> loadPersistenceStorage(String key);
  Future<bool> isExistKey(String key);
}

const String viewCompletedItemsKey = 'view_completed_items';
