import 'package:flutter/material.dart';

abstract class ColorManager {
  static const primary = Color(0xFF1A50A4);
  static const secondary = Color(0xff155DFC);
  static const black = Color(0xFF0A0A0A);
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFF6A7282);
  static const darkGrey = Color(0xFF45556C);
  static const lightGrey = Color(0xFFECEEF2);
  static const orange = Color(0xFFFB9400);
  static const green = Color(0xff7BBF33);
  static const muneGreen = Color(0xffDCFCE7);
  static const red = Color(0xffE7000B);
  static const borderColor = Color(0xffE2E8F0);
  static const notificationBorderColor = Color(0xffBEDBFF);
  static const reatingAvaterColor = Color(0xFFFFFCDA);
  static const homeAppBarGradient = [Color(0xFF1A50A4), Color(0xFF155DFC)];
  static const wheatherUpGradient = [Color(0xFF1754E8), Color(0xFFD9D9D9)];
  static const wheatherDownGradient = [Color(0xFF373333), Color(0xFFffffff)];
  static const addEventGradient = [Color(0xFF2B7FFF), Color(0xFF155DFC)];
  static const addClassifiedGradient = [Color(0xFF615FFF), Color(0xFF4f39f6)];
  static const addMissingPlaceGradient = [Color(0xFFAD46FF), Color(0xFF9810FA)];
  static const categoryItemDetailsGradinet = Color(0xff0F172B);
  static const onBoardingGradient = [Color(0xFF155DFC), Color(0xFF1A50A4), Color(0xFF155DFC)];
  static const onBoardingShadowColor = Color(0xFF171766);
  static const _primarySwatch = {
    50: Color(0xFFE8EEFA),
    100: Color(0xFFDBEAFE),
    200: Color(0xFFA1B3E8),
    300: Color(0xFF7B93DF),
    400: Color(0xFF5E7BD8),
    500: Color(0xFF1A50A4),
    600: Color(0xFF184A97),
    700: Color(0xFF144085),
    800: Color(0xFF103774),
    900: Color(0xFF0A2755),
  };

  static const _nPrimarySwatch = {
    1: Color(0xFFFFFFFF),
    2: Color(0xFFF9FAFC),
    3: Color(0xFFF1F4FA),
    4: Color(0xFFE6ECF7),
    5: Color(0xFFD4DEF1),
    6: Color(0xFFBCCBE8),
    7: Color(0xFFA0B4DE),
    8: Color(0xFF849DD4),
    9: Color(0xFF6987CA),
    10: Color(0xFF4F71C0),
    11: Color(0xFF3C61B8),
    12: Color(0xFF2B55AF),
    13: Color(0xFF1A50A4),
  };

  static const _blackSwatch = {
    1: Color(0xFFFFFFFF),
    2: Color(0xFFF8F9FA),
    3: Color(0xFFF0F1F3),
    4: Color(0xFFE3E5E9),
    5: Color(0xFFC9CCD3),
    6: Color(0xFFADB2BD),
    7: Color(0xFF8E95A3),
    8: Color(0xFF6A7282),
    9: Color(0xFF596172),
    10: Color(0xFF4B5568),
    11: Color(0xFF45556C),
    12: Color(0xFF2C2F38),
    13: Color(0xFF0A0A0A),
  };

  static final primarySwatch = ColorSwatch(primary.value, _primarySwatch);
  static final nPrimarySwatch = ColorSwatch(primary.value, _nPrimarySwatch);
  static final blackSwatch = ColorSwatch(black.value, _blackSwatch);
}
