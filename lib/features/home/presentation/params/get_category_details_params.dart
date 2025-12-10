import 'package:json_annotation/json_annotation.dart';
part 'get_category_details_params.g.dart';

@JsonSerializable(includeIfNull: false)
class GetCategoryDetailsParams {
  final double latitude;
  final double longitude;
  final String? search;
  final int limit;
  final int page;
  @JsonKey(name: "city_id")
  final String cityId;

  GetCategoryDetailsParams({
    required this.latitude,
    required this.longitude,
    this.search,
    required this.limit,
    required this.page,
    required this.cityId,
  });

  Map<String, dynamic> toJson() => _$GetCategoryDetailsParamsToJson(this);
}
