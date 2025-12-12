import 'package:json_annotation/json_annotation.dart';

part 'category_item_model.g.dart';

/// =========================
/// DATA WRAPPER
/// =========================

@JsonSerializable(explicitToJson: true)
class ItemData {
  final Item? item;
  final UI? ui;
  @JsonKey(name: 'is_claim')
  final bool? isClaim;
  @JsonKey(name: 'is_have_menu')
  final bool? isHaveMune;

  ItemData({this.item, this.ui, this.isClaim, this.isHaveMune});
  factory ItemData.fromJson(Map<String, dynamic> json) => _$ItemDataFromJson(json);
  Map<String, dynamic> toJson() => _$ItemDataToJson(this);
}

/// =========================
/// ITEM SECTION
/// =========================

@JsonSerializable(explicitToJson: true)
class Item {
  final String id;
  final String name;
  final String? description;
  final String? address;
  final ItemLocation? location;
  final Rating? rating;
  final List<String>? images;
  final SocialLinks? social;
  final Flags? flags;
  Item({
    required this.id,
    required this.name,
    this.description,
    this.address,
    this.location,
    this.rating,
    this.images,
    this.social,
    this.flags,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

/// =========================
/// ITEM LOCATION
/// =========================

@JsonSerializable()
class ItemLocation {
  final double? latitude;
  final double? longitude;
  @JsonKey(name: "city_id")
  final String? cityId;

  ItemLocation({this.latitude, this.longitude, this.cityId});

  factory ItemLocation.fromJson(Map<String, dynamic> json) => _$ItemLocationFromJson(json);
  Map<String, dynamic> toJson() => _$ItemLocationToJson(this);
}

/// =========================
/// RATING
/// =========================

@JsonSerializable()
class Rating {
  final int? average;
  final Map<String, dynamic>? distribution;

  Rating({this.average, this.distribution});

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

/// =========================
/// SOCIAL LINKS
/// =========================

@JsonSerializable()
class SocialLinks {
  final String? facebook;
  final String? instagram;

  SocialLinks({this.facebook, this.instagram});

  factory SocialLinks.fromJson(Map<String, dynamic> json) => _$SocialLinksFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLinksToJson(this);
}

/// =========================
/// UI SECTION
/// =========================

@JsonSerializable(explicitToJson: true)
class UI {
  final Contacts? contacts;
  final List<OptionItem>? options;

  @JsonKey(name: "working_hours")
  final WorkingHours? workingHours;

  UI({this.contacts, this.options, this.workingHours});

  factory UI.fromJson(Map<String, dynamic> json) => _$UIFromJson(json);
  Map<String, dynamic> toJson() => _$UIToJson(this);
}

/// =========================
/// CONTACTS
/// =========================

@JsonSerializable(explicitToJson: true)
class Contacts {
  final List<ContactNumber>? numbers;
  final List<ContactEmail>? emails;
  final List<ContactUrl>? urls;

  Contacts({this.numbers, this.emails, this.urls});

  factory Contacts.fromJson(Map<String, dynamic> json) => _$ContactsFromJson(json);
  Map<String, dynamic> toJson() => _$ContactsToJson(this);
}

/// =========================
/// CONTACT NUMBER
/// =========================

@JsonSerializable()
class ContactNumber {
  final String? type;
  final String? svg;
  final String? title;
  final String? number;
  final String? link;

  ContactNumber({this.type, this.svg, this.title, this.number, this.link});

  factory ContactNumber.fromJson(Map<String, dynamic> json) => _$ContactNumberFromJson(json);
  Map<String, dynamic> toJson() => _$ContactNumberToJson(this);
}

/// =========================
/// CONTACT EMAIL
/// =========================

@JsonSerializable()
class ContactEmail {
  final String? svg;

  @JsonKey(name: "name_shown")
  final bool? nameShown;

  final String? value;
  final String? title;

  ContactEmail({this.svg, this.nameShown, this.value, this.title});

  factory ContactEmail.fromJson(Map<String, dynamic> json) => _$ContactEmailFromJson(json);
  Map<String, dynamic> toJson() => _$ContactEmailToJson(this);
}

/// =========================
/// CONTACT URL
/// =========================

@JsonSerializable()
class ContactUrl {
  final String? svg;
  final String? value;
  final String? title;

  ContactUrl({this.svg, this.value, this.title});

  factory ContactUrl.fromJson(Map<String, dynamic> json) => _$ContactUrlFromJson(json);
  Map<String, dynamic> toJson() => _$ContactUrlToJson(this);
}

/// =========================
/// OPTIONS
/// =========================

@JsonSerializable()
class OptionItem {
  final String? svg;
  @JsonKey(name: "name_shown")
  final bool? nameShown;
  final dynamic value;
  final String? title;

  OptionItem({this.svg, this.nameShown, this.value, this.title});

  factory OptionItem.fromJson(Map<String, dynamic> json) => _$OptionItemFromJson(json);
  Map<String, dynamic> toJson() => _$OptionItemToJson(this);
}

/// =========================
/// WORKING HOURS
/// =========================

@JsonSerializable(explicitToJson: true)
class WorkingHours {
  @JsonKey(name: "is_open_now")
  final bool? isOpenNow;

  final String? label;

  @JsonKey(name: "status_text")
  final String? statusText;

  @JsonKey(name: "day_name")
  final String? dayName;

  final WorkingRaw? raw;

  WorkingHours({this.isOpenNow, this.label, this.statusText, this.dayName, this.raw});

  factory WorkingHours.fromJson(Map<String, dynamic> json) => _$WorkingHoursFromJson(json);
  Map<String, dynamic> toJson() => _$WorkingHoursToJson(this);
}

/// =========================
/// RAW WORKING HOURS
/// =========================

@JsonSerializable()
class WorkingRaw {
  final String? open;
  final String? close;

  WorkingRaw({this.open, this.close});

  factory WorkingRaw.fromJson(Map<String, dynamic> json) => _$WorkingRawFromJson(json);
  Map<String, dynamic> toJson() => _$WorkingRawToJson(this);
}

/// =========================
/// flags
/// =========================

@JsonSerializable()
class Flags {
  @JsonKey(name: "is_saved")
  final bool isSaved;
  @JsonKey(name: "is_rated")
  final bool isRated;

  Flags({required this.isSaved, required this.isRated});

  factory Flags.fromJson(Map<String, dynamic> json) => _$FlagsFromJson(json);
  Map<String, dynamic> toJson() => _$FlagsToJson(this);
}
