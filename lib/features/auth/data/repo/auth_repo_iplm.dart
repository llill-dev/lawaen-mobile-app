import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/auth/data/models/user_model.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo.dart';
import 'package:lawaen/features/auth/presentation/params/change_password_params.dart';
import 'package:lawaen/features/auth/presentation/params/login_params.dart';
import 'package:lawaen/features/auth/presentation/params/register_params.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AppServiceClient appServiceClient;

  AuthRepoImpl({required this.appServiceClient});
  @override
  Future<Either<ErrorModel, UserModel>> register(RegisterParams params) async {
    MultipartFile? file;
    try {
      if (params.image != null) {
        file = await MultipartFile.fromFile(params.image!.path, filename: params.image!.path.split('/').last);
      }
      final response = await appServiceClient.register(
        name: params.name,
        email: params.email,
        password: params.password,
        phone: params.phone,
        device: params.device,
        image: file,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.errors?[0]));
    } on DioException catch (e) {
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, UserModel>> login(LoginParams params) async {
    try {
      final response = await appServiceClient.login(params);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.errors?[0]));
    } on DioException catch (e) {
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, UserModel>> chagnePassword(ChangePasswordParams params) async {
    try {
      final response = await appServiceClient.changePassword(params);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.errors?[0]));
    } on DioException catch (e) {
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
