import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/profile/data/repos/profile_repo.dart';
import 'package:lawaen/features/profile/presentation/params/contact_us_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoIplm implements ProfileRepo {
  final AppServiceClient appServiceClient;

  ProfileRepoIplm(this.appServiceClient);

  @override
  Future<Either<ErrorModel, Unit>> contactUs(ContactUsParams params) async {
    try {
      final response = await appServiceClient.contactUS(params);
      if (response.success == true) {
        return const Right(unit);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
