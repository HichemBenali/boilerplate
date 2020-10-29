import 'package:shared_preferences/shared_preferences.dart';

class StorageDriver {
  static final StorageDriver _singleton = StorageDriver._internal();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  StorageDriver._internal();
  factory StorageDriver() {
    return _singleton;
  }

  Future<String> read(String key) async {
    SharedPreferences storage = await prefs;
    return storage.get(key);
  }

  write(String key, String value) async {
    SharedPreferences storage = await prefs;
    return storage.setString(key, value);
  }

  Future<List<String>> readList(String key) async {
    SharedPreferences storage = await prefs;
    return storage.getStringList(key);
  }

  writeList(String key, List<String> values) async {
    SharedPreferences storage = await prefs;
    return storage.setStringList(key, values);
  }
}
