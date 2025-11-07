import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaginationParams {
  final int page;
  final int perPage;

  PaginationParams({required this.page, required this.perPage});

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
