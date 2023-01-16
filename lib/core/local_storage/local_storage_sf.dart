import 'package:local_storage/core/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSF extends LocalStorage {
  SharedPreferences? pref;

  @override
  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Future<LocalStorageResult> saveBool(String key, bool value) async {
    if (pref == null) await init();

    try {
      await pref?.setBool(key, value);
      return LocalStorageResult.saved;
    } catch (e) {
      return LocalStorageResult.failed;
    }
  }

  @override
  Future<LocalStorageResult> saveInt(String key, int value) async {
    if (pref == null) await init();

    try {
      await pref?.setInt(key, value);
      return LocalStorageResult.saved;
    } catch (e) {
      return LocalStorageResult.failed;
    }
  }

  @override
  Future<LocalStorageResult> saveString(String key, String value) async {
    if (pref == null) await init();

    try {
      await pref?.setString(key, value);
      return LocalStorageResult.saved;
    } catch (e) {
      return LocalStorageResult.failed;
    }
  }

  @override
  Future<bool> getBool(String key) async {
    if (pref == null) await init();

    try {
      return pref?.getBool(key) ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int?> getInt(String key) async {
    if (pref == null) await init();

    try {
      return pref?.getInt(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getString(String key) async {
    if (pref == null) await init();

    try {
      return pref?.getString(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<LocalStorageResult> removeData(String key) async {
    if (pref == null) await init();

    try {
      await pref?.remove(key);
      return LocalStorageResult.deleted;
    } catch (e) {
      return LocalStorageResult.failed;
    }
  }
}
