import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/onboarding/data/models/onboarding_message_model.dart';

abstract class OnboardingRepo {
  Future<Either<ErrorModel, OnboardingMessageModel>> getAdminMessage();
}
