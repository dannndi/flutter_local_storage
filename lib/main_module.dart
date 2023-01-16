import 'package:get_it/get_it.dart';
import 'package:local_storage/core/local_storage/local_storage.dart';
import 'package:local_storage/core/local_storage/local_storage_ss.dart';

class MainModule {
  static void init() {
    GetIt.I.registerSingletonAsync<LocalStorage>(
      () async => LocalStorageSS()..init(),
    );
  }
}
