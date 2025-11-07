import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/refresh_cubit/refresh_cubit.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection(String env) async {
  if (!GetIt.I.isRegistered(instance: SharedPreferences)) {
    await getIt.reset();
    getIt.registerLazySingleton<Connectivity>(() => Connectivity());
    getIt.registerLazySingleton<RefreshCubit>(() => RefreshCubit());
  }
  getIt.init(environment: env);
}
