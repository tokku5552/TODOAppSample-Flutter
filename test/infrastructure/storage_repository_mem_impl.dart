import 'package:todo_app_sample_flutter/domain/storage_repository.dart';

class StorageRepositoryMemImpl implements StorageRepository {
  // { key : value }
  final _data = <String, String>{};

  void clear() {
    _data.clear();
  }

  @override
  Future<bool> isExistKey(String key) {
    return Future.value(_data[key] != null);
  }

  @override
  Future<String> loadPersistenceStorage(String key) {
    return Future.value(_data[key]);
  }

  @override
  Future<void> savePersistenceStorage(String key, String value) {
    _data[key] = value;
    return null;
  }
}
