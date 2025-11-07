import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: true, fieldRename: FieldRename.snake)
class ApiResponse<T> extends Equatable {
  @JsonKey(defaultValue: null)
  final String? message;
  final dynamic success;
  final int? statusCode;
  final T? data;
  final List<String>? errors;

  const ApiResponse({
    this.message = 'Something went wrong',
    this.statusCode = 403,
    this.data,
    this.errors,
    this.success = false,
  });

  const ApiResponse.data({
    required this.message,
    required this.statusCode,
    required this.success,
    required this.data,
    required this.errors,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$ApiResponseToJson(this, toJsonT);

  @override
  List<Object?> get props => [data];
}
