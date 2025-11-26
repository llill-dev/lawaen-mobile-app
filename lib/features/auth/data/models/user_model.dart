import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lawaen/features/auth/data/models/token_model.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserDataModel {
  final UserModel user;
  final TokenModel tokens;
  const UserDataModel({required this.user, required this.tokens});

  factory UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserModel extends Equatable {
  @JsonKey(name: '_id')
  final String? rigsterId;
  @JsonKey(name: 'id')
  final String? loginId;
  final String name;
  final String? image;
  final String? email;
  final String? password;
  final bool? status;
  final String? source;
  @JsonKey(name: 'user_type')
  final String? userType;
  @JsonKey(name: 'phone')
  final String? phoneNumber;
  @JsonKey(name: 'is_add_miss_place')
  final bool? isAddMissPlace;
  @JsonKey(name: 'is_add_ads')
  final bool? isAddAds;
  @JsonKey(name: 'is_add_event')
  final bool? isAddEvent;
  @JsonKey(name: 'is_add_offer')
  final bool? isAddOffer;
  @JsonKey(name: 'is_upload_reels')
  final bool? isUploadReels;
  @JsonKey(name: 'passcode_active')
  final bool? passcodeActive;

  const UserModel({
    required this.name,
    this.loginId,
    this.rigsterId,
    this.image,
    this.email,
    this.password,
    this.status,
    this.source,
    this.userType,
    this.phoneNumber,
    this.isAddMissPlace,
    this.isAddAds,
    this.isAddEvent,
    this.isAddOffer,
    this.isUploadReels,
    this.passcodeActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
    loginId,
    rigsterId,
    name,
    image,
    email,
    password,
    status,
    source,
    userType,
    phoneNumber,
    isAddMissPlace,
    isAddAds,
    isAddEvent,
    isAddOffer,
    isUploadReels,
    passcodeActive,
  ];
}
