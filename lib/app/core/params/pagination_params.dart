import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int page;
  final int limit;

  PaginationParams({required this.page, required this.limit});

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
