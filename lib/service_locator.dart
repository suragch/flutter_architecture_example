//import 'storage_service_fake.dart';
import 'storage_service_shared_pref.dart';

import 'package:get_it/get_it.dart';
import 'storage_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  //getIt.registerLazySingleton<StorageService>(() => StorageServiceFake());
  getIt.registerLazySingleton<StorageService>(
      () => StorageServiceSharedPreferences());
}
