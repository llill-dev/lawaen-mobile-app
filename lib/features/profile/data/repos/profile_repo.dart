import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/profile/presentation/params/contact_us_params.dart';

abstract class ProfileRepo {
  Future<Either<ErrorModel, Unit>> contactUs(ContactUsParams params);
}
