import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_storage/core/local_storage/local_storage.dart';

class LocalStorageSS extends LocalStorage {
  FlutterSecureStorage? storage;

  @override
  Future<void> init() async {
    storage = const FlutterSecureStorage();
  }

  @override
  Future<LocalStorageResult> saveBool(String key, bool value) async {
    if (storage == null) await init();

    try {
      /// true = 1, false = 0
      await storage?.write(key: key, value: value ? "1" : "0");
      return LocalStorageResult.saved;
    } catch (e) {
      return LocalStorageResult.failed;
    }
  }

  @override
  Future<LocalStorageResult> saveInt(String key, int value) async {
    if (storage == null) await init();

    try {
      await storage?.write(key: key, value: value.toString());
      return LocalStorageResult.saved;
    } catch (e) {
      return LocalStorageResult.failed;
    }
  }

  @override
  Future<LocalStorageResult> saveString(String key, String value) async {
    if (storage == null) await init();

    try {
      await storage?.write(key: key, value: value);
      return LocalStorageResult.saved;
    } catch (e) {
      return LocalStorageResult.failed;
    }
  }

  @override
  Future<bool> getBool(String key) async {
    if (storage == null) await init();

    try {
      final result = await storage?.read(key: key);

      return result == "1";
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int?> getInt(String key) async {
    if (storage == null) await init();

    try {
      final result = await storage?.read(key: key);

      final number = int.tryParse(result ?? "");
      return number;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getString(String key) async {
    if (storage == null) await init();

    try {
      return await storage?.read(key: key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<LocalStorageResult> removeData(String key) async {
    if (storage == null) await init();

    try {
      await storage?.delete(key: key);
      return LocalStorageResult.deleted;
    } catch (e) {
      return LocalStorageResult.failed;
    }
  }
}
