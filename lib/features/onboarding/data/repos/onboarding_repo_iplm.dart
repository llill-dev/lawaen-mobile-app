import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/onboarding/data/models/onboarding_message_model.dart';
import 'package:lawaen/features/onboarding/data/repos/onboarding_repo.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: OnboardingRepo)
class OnboardingRepoIplm implements OnboardingRepo {
  final AppServiceClient appServiceClient;

  OnboardingRepoIplm(this.appServiceClient);

  @override
  Future<Either<ErrorModel, OnboardingMessageModel>> getAdminMessage() async {
    try {
      final response = await appServiceClient.getAdminMessage();
      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
