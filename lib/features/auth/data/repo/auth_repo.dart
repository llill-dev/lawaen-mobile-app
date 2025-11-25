import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/auth/data/models/user_model.dart';
import 'package:lawaen/features/auth/presentation/params/change_password_params.dart';
import 'package:lawaen/features/auth/presentation/params/login_params.dart';
import 'package:lawaen/features/auth/presentation/params/register_params.dart';

abstract class AuthRepo {
  Future<Either<ErrorModel, UserModel>> register(RegisterParams params);

  Future<Either<ErrorModel, UserModel>> login(LoginParams params);

  Future<Either<ErrorModel, UserModel>> chagnePassword(ChangePasswordParams params);
}
