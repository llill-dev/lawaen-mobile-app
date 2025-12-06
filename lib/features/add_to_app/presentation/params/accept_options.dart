import 'package:json_annotation/json_annotation.dart';
part 'accept_options.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: true)
class AcceptOptions {
  final bool? acceptOne;
  final bool? acceptTwo;
  final bool? acceptThree;

  const AcceptOptions({this.acceptOne, this.acceptTwo, this.acceptThree});

  AcceptOptions copyWith({bool? acceptOne, bool? acceptTwo, bool? acceptThree}) {
    return AcceptOptions(
      acceptOne: acceptOne ?? this.acceptOne,
      acceptTwo: acceptTwo ?? this.acceptTwo,
      acceptThree: acceptThree ?? this.acceptThree,
    );
  }

  factory AcceptOptions.fromJson(Map<String, dynamic> json) => _$AcceptOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptOptionsToJson(this);
}
