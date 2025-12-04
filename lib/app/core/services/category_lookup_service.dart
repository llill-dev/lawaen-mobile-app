import 'package:injectable/injectable.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';

@lazySingleton
class CategoryLookupService {
  final Map<String, SecondCategory> _subcategoriesById = {};

  /// Call this whenever categories are loaded/refreshed
  void load(List<CategoryModel> categories) {
    _subcategoriesById
      ..clear()
      ..addEntries(categories.expand((cat) => cat.secondCategory).map((subCat) => MapEntry(subCat.id, subCat)));
  }

  SecondCategory? getSubCategory(String? subCategoryId) {
    if (subCategoryId == null) return null;
    return _subcategoriesById[subCategoryId];
  }

  String? getSubCategoryIconUrl(String? subCategoryId) {
    return getSubCategory(subCategoryId)?.image;
  }

  bool hasSubCategory(String? subCategoryId) {
    if (subCategoryId == null) return false;
    return _subcategoriesById.containsKey(subCategoryId);
  }
}
