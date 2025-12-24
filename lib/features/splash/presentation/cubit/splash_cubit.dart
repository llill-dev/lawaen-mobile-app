import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'splash_state.dart';

@Injectable()
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  final Connectivity _connectivity = Connectivity();

  Future<void> checkInternetAndProceed() async {
    emit(SplashCheckingNetwork());

    final connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(SplashNoInternet());
      return;
    }

    final hasInternet = await _hasRealInternet();

    if (!hasInternet) {
      emit(SplashNoInternet());
      return;
    }

    emit(SplashNavigate());
  }

  Future<bool> _hasRealInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
