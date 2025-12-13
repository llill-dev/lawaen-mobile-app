import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/features/events/presentation/params/get_events_params.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/data/models/city_model.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/data/models/mune_model.dart';
import 'package:lawaen/features/home/data/models/register_fcm_token_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
import 'package:lawaen/features/home/presentation/params/get_menu_params.dart';
import 'package:lawaen/features/home/presentation/params/register_fcm_token_params.dart';

abstract class HomeRepo {
  Future<Either<ErrorModel, List<CityModel>>> getCities();
  Future<Either<ErrorModel, List<CategoryModel>>> getCategories();
  Future<Either<ErrorModel, List<EventModel>>> getHomeEvents(GetEventsParams params);
  Future<Either<ErrorModel, RegisterFcmTokenModel>> registerFcmToken(RegisterFcmTokenParams params);
  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getHomeData(GetCategoryDetailsParams params);
  Future<Either<ErrorModel, MuneModel>> getMune(GetMenuParams params);
}
