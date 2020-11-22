import 'package:shared_preferences/shared_preferences.dart';

class PersistenceStorageProvider {
  PersistenceStorageProvider._();

  static final PersistenceStorageProvider instance =
      PersistenceStorageProvider._();

  SharedPreferences _prefs;

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs;
    _prefs = await initSharedPreferences();
    return _prefs;
  }

  initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
