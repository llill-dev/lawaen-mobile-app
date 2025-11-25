import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/services/device_info_service.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/features/auth/data/models/user_model.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo.dart';
import 'package:lawaen/features/auth/presentation/params/change_password_params.dart';
import 'package:lawaen/features/auth/presentation/params/login_params.dart';
import 'package:lawaen/features/auth/presentation/params/register_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

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
      (error) => emit(AuthFailure(errorMessage: error.errorMessage ?? LocaleKeys.defaultError.tr())),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> login({String? email, required String password, String? phoneNumber}) async {
    emit(AuthLoading());
    final device = await getIt<DeviceInfoService>().getDeviceInfo();
    final params = LoginParams(email: email, password: password, phone: phoneNumber, device: device);
    final result = await _authRepo.login(params);
    result.fold(
      (error) => emit(AuthFailure(errorMessage: error.errorMessage ?? LocaleKeys.defaultError.tr())),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String phoneNumberOrEmail,
  }) async {
    emit(AuthLoading());
    final result = await _authRepo.chagnePassword(
      ChangePasswordParams(oldPassword: oldPassword, newPassword: newPassword, login: phoneNumberOrEmail),
    );
    result.fold(
      (error) => emit(AuthFailure(errorMessage: error.errorMessage ?? LocaleKeys.defaultError.tr())),
      (user) => emit(AuthSuccess(user: user)),
    );
  }
}
