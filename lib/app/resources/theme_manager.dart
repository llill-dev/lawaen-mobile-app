import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'styles_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: 'Arimo',
    splashFactory: NoSplash.splashFactory,
    bottomSheetTheme: BottomSheetThemeData(
      dragHandleSize: Size(94.w, 4.h),
      dragHandleColor: ColorManager.blackSwatch[4],
      backgroundColor: ColorManager.white,
    ),

    /// main colors
    primaryColor: ColorManager.primary,

    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      checkColor: WidgetStatePropertyAll(ColorManager.primary),
      fillColor: WidgetStatePropertyAll(ColorManager.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: ColorManager.primary)),

    /// like disabled color
    splashColor: ColorManager.primarySwatch[50],

    /// ripple effect color when you press and hold on the button or something else
    iconTheme: IconThemeData(color: ColorManager.primary),

    cardTheme: CardThemeData(
      color: ColorManager.white,
      shadowColor: ColorManager.blackSwatch[11],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    appBarTheme: AppBarTheme(
      centerTitle: false,
      actionsIconTheme: IconThemeData(color: ColorManager.primary),
      backgroundColor: ColorManager.primary,
      elevation: 0,
      foregroundColor: Colors.transparent,
      toolbarHeight: 0,
      scrolledUnderElevation: 0,
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primarySwatch[50],
    ),

    textTheme: TextTheme(
      /// BOLD FONTS w700 - black color
      displayLarge: getBoldStyle(color: ColorManager.blackSwatch[13]!, fontSize: 18),
      displayMedium: getBoldStyle(color: ColorManager.blackSwatch[12]!, fontSize: 16),
      displaySmall: getBoldStyle(color: ColorManager.blackSwatch[8]!, fontSize: 14),

      /// SEMI BOLD W-600
      bodyLarge: getSemiBoldStyle(color: ColorManager.blackSwatch[13]!, fontSize: 18),
      bodyMedium: getSemiBoldStyle(color: ColorManager.blackSwatch[12]!, fontSize: 16),
      bodySmall: getSemiBoldStyle(color: ColorManager.blackSwatch[8]!, fontSize: 14),

      /// Medium W-500
      titleLarge: getMediumStyle(color: ColorManager.blackSwatch[13]!, fontSize: 18),
      titleMedium: getMediumStyle(color: ColorManager.blackSwatch[11]!, fontSize: 16),
      titleSmall: getMediumStyle(color: ColorManager.blackSwatch[8]!, fontSize: 14),

      /// regular W-400
      headlineLarge: getRegularStyle(color: ColorManager.blackSwatch[13]!, fontSize: 18),
      headlineMedium: getRegularStyle(color: ColorManager.blackSwatch[12]!, fontSize: 16),
      headlineSmall: getRegularStyle(color: ColorManager.blackSwatch[8]!, fontSize: 14),

      /// light W-300
      labelLarge: getLightStyle(color: ColorManager.blackSwatch[13]!, fontSize: 18),
      labelMedium: getRegularStyle(color: ColorManager.blackSwatch[12]!, fontSize: 16),
      labelSmall: getMediumStyle(color: ColorManager.blackSwatch[8]!, fontSize: 14),
    ),

    /// input decoration -> text form field
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: REdgeInsets.all(10),
      prefixIconColor: ColorManager.primary,
      suffixIconColor: ColorManager.primary,
      iconColor: ColorManager.primary,
      filled: true,
      hintStyle: getRegularStyle(color: ColorManager.blackSwatch[8]!, fontSize: 16),
      fillColor: ColorManager.white,
      labelStyle: getMediumStyle(color: ColorManager.blackSwatch[11]!, fontSize: 14),
      errorStyle: getRegularStyle(color: ColorManager.primarySwatch[50]!, fontSize: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.blackSwatch[3]!, width: 1_5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.blackSwatch[13]!, width: 1_5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1_5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),

      /// focus on the border after getting the validation error
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1_5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
    ),
    dividerColor: Colors.transparent,
    expansionTileTheme: ExpansionTileThemeData(
      // tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      iconColor: ColorManager.primary,
      collapsedIconColor: ColorManager.primary,
    ),
    scaffoldBackgroundColor: ColorManager.white,
    iconButtonTheme: IconButtonThemeData(style: ButtonStyle(iconColor: WidgetStatePropertyAll(ColorManager.primary))),
    scrollbarTheme: const ScrollbarThemeData().copyWith(
      thumbColor: WidgetStatePropertyAll(ColorManager.blackSwatch[11]!),
      interactive: true,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorManager.primary,
      selectionColor: ColorManager.primarySwatch[50],
      selectionHandleColor: ColorManager.primarySwatch[50],
    ),
  );
}
