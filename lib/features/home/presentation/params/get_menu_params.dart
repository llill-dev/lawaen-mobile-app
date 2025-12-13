import 'package:json_annotation/json_annotation.dart';
part 'get_menu_params.g.dart';

@JsonSerializable()
class GetMenuParams {
  @JsonKey(name: "second")
  final String categoryId;
  @JsonKey(name: "model_id")
  final String itemId;

  GetMenuParams({required this.categoryId, required this.itemId});

  Map<String, dynamic> toJson() => _$GetMenuParamsToJson(this);
}
