import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import '../../../../../../app/resources/color_manager.dart';

class LocationItemSection extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  const LocationItemSection({super.key, this.latitude, this.longitude});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.secondary.withValues(alpha: .25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            IconManager.location,
            colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
            width: 50.w,
            height: 50.h,
          ),
          15.verticalSpace,
          // Text("Damascus Bluewaters Island", style: Theme.of(context).textTheme.headlineMedium),
          15.verticalSpace,
          PrimaryButton(
            text: LocaleKeys.openInMap.tr(),
            onPressed: () async {
              if (latitude != null && longitude != null) {
                await getIt<LocationService>().openLocationInMaps(latitude: latitude!, longitude: longitude!);
              }
            },
          ),
        ],
      ),
    ).horizontalPadding(padding: 16.w);
  }
}
