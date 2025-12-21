import 'package:json_annotation/json_annotation.dart';

part 'onboarding_message_model.g.dart';

@JsonSerializable()
class OnboardingMessageModel {
  final String? id;
  final String? message;
  final String? btn;
  final String? image;

  @JsonKey(name: 'go_to')
  final String? goTo;

  const OnboardingMessageModel({this.id, this.message, this.btn, this.image, this.goTo});

  factory OnboardingMessageModel.fromJson(Map<String, dynamic> json) => _$OnboardingMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$OnboardingMessageModelToJson(this);
}
