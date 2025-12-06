import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../core/refresh_cubit/refresh_cubit.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection(String env) async {
  await getIt.init(environment: env);

  if (!getIt.isRegistered<Connectivity>()) {
    getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  }

  if (!getIt.isRegistered<RefreshCubit>()) {
    getIt.registerLazySingleton<RefreshCubit>(() => RefreshCubit());
  }
}
