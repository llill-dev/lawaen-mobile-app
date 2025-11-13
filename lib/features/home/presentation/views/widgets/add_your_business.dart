import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/routes/router.gr.dart';

import '../../../../../app/resources/color_manager.dart';
import '../../../../../generated/locale_keys.g.dart';

class AddYourBusiness extends StatelessWidget {
  const AddYourBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(AddRoute()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: ColorManager.white,
          boxShadow: [BoxShadow(color: ColorManager.primary, blurRadius: 4, spreadRadius: 0, offset: Offset(0, 4))],
          border: Border.all(color: ColorManager.primary, width: 1.w),
        ),
        child: Text(
          LocaleKeys.addYourBusiness.tr(),
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
