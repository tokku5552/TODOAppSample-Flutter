abstract class StorageRepository {
  Future<void> savePersistenceStorage(String key, String value);
  Future<String> loadPersistenceStorage(String key);
  Future<bool> isExistKey(String key);
}
const String VIEW_COMPLETED_ITEMS_KEY = "view_completed_items";
const String VIEW_COMPLETED_ITEMS_KEY_NONE = "NONE";
