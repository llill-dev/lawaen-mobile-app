import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/api_response.dart';
import 'package:lawaen/app/network/urls.dart';
import 'package:lawaen/features/auth/data/models/token_model.dart';
import 'package:lawaen/features/auth/data/models/user_model.dart';
import 'package:lawaen/features/auth/presentation/params/change_password_params.dart';
import 'package:lawaen/features/auth/presentation/params/login_params.dart';
import 'package:lawaen/features/add_to_app/data/models/add_event_model.dart';
import 'package:lawaen/features/add_to_app/data/models/add_missing_plcae_model.dart';
import 'package:lawaen/features/add_to_app/data/models/add_offer_model.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/features/events/data/models/event_type_model.dart';
import 'package:lawaen/features/events/presentation/params/get_events_params.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/data/models/city_model.dart';
import 'package:lawaen/features/home/data/models/mune_model.dart';
import 'package:lawaen/features/home/data/models/register_fcm_token_model.dart';
import 'package:lawaen/features/home/presentation/params/get_menu_params.dart';
import 'package:lawaen/features/home/presentation/params/register_fcm_token_params.dart';
import 'package:lawaen/features/nearby/data/models/map_marker_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
import 'package:lawaen/features/offers/data/models/offer_type_model.dart';
import 'package:lawaen/features/offers/data/models/offer_model.dart';
import 'package:lawaen/features/offers/presentation/params/get_offers_params.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../config/configuration.dart';
part 'app_api.g.dart';

@lazySingleton
@RestApi()
abstract class AppServiceClient {
  @factoryMethod
  factory AppServiceClient(Dio dio, Configuration configuration) {
    return _AppServiceClient(dio, baseUrl: configuration.getBaseUrl);
  }

  //Auth
  @POST(Urls.login)
  Future<ApiResponse<UserDataModel>> login(@Body() LoginParams params);

  @MultiPart()
  @POST(Urls.register)
  Future<ApiResponse<UserDataModel>> register({
    @Part(name: "name") required String name,
    @Part(name: "email") String? email,
    @Part(name: "password") required String password,
    @Part(name: "phone") String? phone,
    @Part(name: "brand") required String brand,
    @Part(name: "model_name") required String modelName,
    @Part(name: "is_device") required bool isDevice,
    @Part(name: "build_id") required String buildId,
    @Part(name: "file") MultipartFile? image,
  });

  @MultiPart()
  @POST(Urls.updateProfile)
  Future<ApiResponse<UserDataModel>> updateProfile({
    @Part(name: "name") String? name,
    @Part(name: "phone") String? phone,
    @Part(name: "email") String? email,
    @Part(name: "gender") String? gender,
    @Part(name: "birthday") String? birthDate,
    @Part(name: "file") MultipartFile? image,
  });

  @POST(Urls.changePassword)
  Future<ApiResponse> changePassword(@Body() ChangePasswordParams params);

  @POST(Urls.refreshToken)
  Future<TokenModel> refreshToken(@Body() Map<String, dynamic> body);

  //Home
  @GET(Urls.getCities)
  Future<ApiResponse<List<CityModel>>> getCities();

  @GET(Urls.getCategories)
  Future<ApiResponse<List<CategoryModel>>> getCategories();

  @GET(Urls.getMapMarkers)
  Future<ApiResponse<List<MapMarkerModel>>> getMapMarkers();

  @GET(Urls.getHomeEvents)
  Future<ApiResponse<List<EventModel>>> getHomeEvents({@Queries() required GetEventsParams params});

  @POST(Urls.registerFcmToken)
  Future<RegisterFcmTokenModel> registerFcmToken({@Body() required RegisterFcmTokenParams params});

  @GET(Urls.homeData)
  Future<ApiResponse<List<CategoryDetailsModel>>> getHomeData({@Queries() required GetCategoryDetailsParams params});

  @GET(Urls.getMune)
  Future<ApiResponse<MuneModel>> getMune({@Queries() required GetMenuParams params});

  //category details
  @GET(Urls.getCategoryDetails)
  Future<ApiResponse<List<CategoryDetailsModel>>> getCategoryDetails({
    @Queries() required GetCategoryDetailsParams params,
    @Path("id") required String id,
  });

  @GET(Urls.getCategoryDetailsBySecond)
  Future<ApiResponse<List<CategoryDetailsModel>>> getCategoryDetailsBySecond({
    @Queries() required GetCategoryDetailsParams params,
    @Path("id") required String id,
  });

  @GET(Urls.getItemData)
  Future<ApiResponse<ItemData>> getItemData({
    @Path("second_id") required String secondId,
    @Path("id") required String id,
  });

  @GET(Urls.searchLocation)
  Future<ApiResponse<List<CategoryDetailsModel>>> searchLocation({@Queries() required GetCategoryDetailsParams params});

  //add to app
  @MultiPart()
  @POST(Urls.addEvent)
  Future<AddEventModel?> addEvent({
    @Part(name: 'event_type') String? eventType,
    @Part(name: 'name') String? name,
    @Part(name: 'description') String? description,
    @Part(name: 'booking_method') String? bookingMethod,
    @Part(name: 'price') String? price,
    @Part(name: 'organization') String? organization,
    @Part(name: 'start_time') String? startTime,
    @Part(name: 'end_time') String? endTime,
    @Part(name: 'start_date') String? startDate,
    @Part(name: 'end_date') String? endDate,
    @Part(name: 'start_event_date') String? startEventDate,
    @Part(name: 'end_event_date') String? endEventDate,
    @Part(name: 'event_time') String? eventTime,
    @Part(name: 'note') String? note,
    @Part(name: 'phone') String? phone,
    @Part(name: 'whatsapp') String? whatsapp,
    @Part(name: 'instagram') String? instagram,
    @Part(name: 'facebook') String? facebook,
    @Part(name: 'latitude') double? latitude,
    @Part(name: 'longitude') double? longitude,
    @Part(name: 'file') MultipartFile? image,
  });

  @MultiPart()
  @POST(Urls.addMissingPlace)
  Future<AddMissingPlcaeModel?> addMissingPlace({
    @Part(name: 'name') String? name,
    @Part(name: 'mainCategory') String? mainCategory,
    @Part(name: 'subCategory') String? subCategory,
    @Part(name: 'message') String? message,
    @Part(name: 'phone') String? phone,
    @Part(name: 'whatsapp') String? whatsapp,
    @Part(name: 'faceBook') String? facebook,
    @Part(name: 'insta') String? instagram,
    @Part(name: 'opentime') String? openTime,
    @Part(name: 'closetime') String? closeTime,
    @Part(name: 'latitude') double? latitude,
    @Part(name: 'longitude') double? longitude,
    @Part(name: 'acceptOne') bool? acceptOne,
    @Part(name: 'acceptTwo') bool? acceptTwo,
    @Part(name: 'acceptThree') bool? acceptThree,
    @Part(name: 'recaptcha') bool? recaptcha,
    @Part(name: 'file') MultipartFile? image,
  });

  @MultiPart()
  @POST(Urls.addOffer)
  Future<AddOfferModel?> addOffer({
    @Part(name: 'name') String? name,
    @Part(name: 'message') String? message,
    @Part(name: 'phone') String? phone,
    @Part(name: 'whatsapp') String? whatsapp,
    @Part(name: 'acceptOne') bool? acceptOne,
    @Part(name: 'acceptTwo') bool? acceptTwo,
    @Part(name: 'acceptThree') bool? acceptThree,
    @Part(name: 'recaptcha') bool? recaptcha,
    @Part(name: 'file') MultipartFile? image,
  });

  //offers
  @GET(Urls.getOfferType)
  Future<ApiResponse<List<OfferTypeModel>>> getOfferType();

  @GET(Urls.getOffers)
  Future<ApiResponse<List<OfferModel>>> getOffers({@Queries() required GetOffersParams params});

  //events
  @GET(Urls.getEventTypes)
  Future<ApiResponse<List<EventTypeModel>>> getEventTypes();

  @GET(Urls.getEvents)
  Future<ApiResponse<List<EventModel>>> getEvents({
    @Queries() required GetEventsParams params,
    @Path("id") required String id,
  });
}
