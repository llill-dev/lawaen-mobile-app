import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';

abstract class ExploreRepo {
  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getExplore(GetCategoryDetailsParams params);
}
