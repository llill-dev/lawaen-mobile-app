import 'package:json_annotation/json_annotation.dart';
part 'counts_model.g.dart';

@JsonSerializable()
class CountsModel {
  final int? saved;
  final int? rated;

  CountsModel({required this.saved, required this.rated});

  factory CountsModel.fromJson(Map<String, dynamic> json) => _$CountsModelFromJson(json);
}
