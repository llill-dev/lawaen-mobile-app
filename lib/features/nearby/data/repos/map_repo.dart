import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
import 'package:lawaen/features/nearby/data/models/map_marker_model.dart';

abstract class MapRepo {
  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getInitialItems(GetCategoryDetailsParams params);

  Future<Either<ErrorModel, List<CategoryModel>>> getCategories();

  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getItemsByCategory(
    String categoryId,
    GetCategoryDetailsParams params,
  );
  Future<Either<ErrorModel, List<MapMarkerModel>>> getMapMarkers();

  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getItemsBySecondCategory(
    String secondCategoryId,
    GetCategoryDetailsParams params,
  );
}
