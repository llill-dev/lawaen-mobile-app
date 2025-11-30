import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';

abstract class CategoryItemDetailsRepo {
  Future<Either<ErrorModel, ItemData>> getCategoryItems({required String secondCategoryId, required String itemId});
}
