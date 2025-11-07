import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: true, fieldRename: FieldRename.snake)
class PaginationModel<T> extends Equatable {
  @JsonKey(defaultValue: null)
  final int? currentPage;
  final int? lastPage;
  final T? data;

  const PaginationModel({this.lastPage, this.data, this.currentPage});

  factory PaginationModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$PaginationModelToJson(this, toJsonT);

  @override
  List<Object?> get props => [data];
}
