import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/profile/data/models/profile_page_model.dart';
import 'package:lawaen/features/profile/data/models/profile_pages_model.dart';
import 'package:lawaen/features/profile/presentation/params/contact_us_params.dart';

abstract class ProfileRepo {
  Future<Either<ErrorModel, Unit>> contactUs(ContactUsParams params);

  Future<Either<ErrorModel, List<ProfilePagesModel>>> getProfilePages();

  Future<Either<ErrorModel, ProfilePageModel>> getProfilePage({required String id});
}
