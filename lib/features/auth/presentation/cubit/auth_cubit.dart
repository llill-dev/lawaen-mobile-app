import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/services/device_info_service.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/features/auth/data/models/user_model.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo.dart';
import 'package:lawaen/features/auth/presentation/params/login_params.dart';
import 'package:lawaen/features/auth/presentation/params/register_params.dart';

part 'auth_state.dart';

@Injectable()
class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  File? profileImage;

  AuthCubit({required AuthRepo authRepo}) : _authRepo = authRepo, super(AuthInitial());

  Future<void> register({required String name, String? email, required String password, String? phoneNumber}) async {
    emit(AuthLoading());
    final device = await getIt<DeviceInfoService>().getDeviceInfo();
    final params = RegisterParams(
      name: name,
      email: email,
      password: password,
      phone: phoneNumber,
      image: profileImage,
      device: device,
    );
    final result = await _authRepo.register(params);
    result.fold(
      (error) => emit(AuthFailure(errorMessage: error.errorMessage)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> login({String? email, required String password, String? phoneNumber}) async {
    emit(AuthLoading());
    final device = await getIt<DeviceInfoService>().getDeviceInfo();
    final params = LoginParams(email: email, password: password, phone: phoneNumber, device: device);
    final result = await _authRepo.login(params);
    result.fold(
      (error) => emit(AuthFailure(errorMessage: error.errorMessage)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }
}
