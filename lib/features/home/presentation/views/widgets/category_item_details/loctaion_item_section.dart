import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

import '../../../../../../app/resources/color_manager.dart';

class LocationItemSection extends StatelessWidget {
  const LocationItemSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: ColorManager.primarySwatch[200],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 4, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          SvgPicture.asset(IconManager.location, color: ColorManager.primary, width: 50.w, height: 50.h),
          15.verticalSpace,
          Text("Damascus Bluewaters Island", style: Theme.of(context).textTheme.headlineMedium),
          15.verticalSpace,
          PrimaryButton(text: "open in map"),
        ],
      ),
    ).horizontalPadding(padding: 16.w);
  }
}
