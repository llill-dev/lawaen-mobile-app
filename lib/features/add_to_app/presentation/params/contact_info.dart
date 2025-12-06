import 'package:json_annotation/json_annotation.dart';

part 'contact_info.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: true)
class ContactInfo {
  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'whatsapp')
  final String? whatsapp;

  @JsonKey(name: 'instagram')
  final String? instagram;

  @JsonKey(name: 'facebook')
  final String? facebook;

  const ContactInfo({
    this.phone,
    this.whatsapp,
    this.instagram,
    this.facebook,
  });

  ContactInfo copyWith({
    String? phone,
    String? whatsapp,
    String? instagram,
    String? facebook,
  }) {
    return ContactInfo(
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
    );
  }

  factory ContactInfo.fromJson(Map<String, dynamic> json) => _$ContactInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ContactInfoToJson(this);
}
