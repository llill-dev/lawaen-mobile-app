import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/features/home/data/models/city_model.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';

abstract class HomeRepo {
  Future<Either<ErrorModel, List<CityModel>>> getCities();
  Future<Either<ErrorModel, List<CategoryModel>>> getCategories();
  Future<Either<ErrorModel, List<EventModel>>> getHomeEvents();
}
