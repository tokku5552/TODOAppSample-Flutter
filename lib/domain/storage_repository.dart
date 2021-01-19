abstract class StorageRepository {
  Future<void> savePersistenceStorage(String key, String value);
  Future<String> loadPersistenceStorage(String key);
  Future<bool> isExistKey(String key);
}
