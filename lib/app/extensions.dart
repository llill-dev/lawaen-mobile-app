import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NonNullString on String? {
  String orEmpty() {
    return this ?? "";
  }
}

extension NonNullInterger on int? {
  int orZero() {
    return this ?? 0;
  }
}

extension NonNullDouble on double? {
  double orZero() {
    return this ?? 0.0;
  }
}

extension NonNullBolean on bool? {
  bool orFalse() {
    return this ?? false;
  }
}

extension HorizontalPadding on Widget {
  Padding horizontalPadding({required double padding}) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: padding),
      child: this,
    );
  }
}
