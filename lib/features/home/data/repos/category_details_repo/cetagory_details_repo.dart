import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';

abstract class CategoryDetailsRepo {
  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getCategoryDetails(String id, GetCategoryDetailsParams params);
}
