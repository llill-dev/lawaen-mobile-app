import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';

import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class MapItemDetailBottomSheet extends StatelessWidget {
  final CategoryDetailsModel item;
  const MapItemDetailBottomSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.name != null)
                Text(item.name!, style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorManager.white)),

              SizedBox(height: 16.h),

              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: (item.image?.isEmpty ?? true)
                      ? Image.asset(ImageManager.emptyPhoto, width: 120.w, height: 120.w, fit: BoxFit.cover)
                      : NetworkIcon(url: item.image!, width: 120.w, height: 120.w, fit: BoxFit.cover),
                ),
              ),

              SizedBox(height: 12.h),

              if (item.location?.address != null && item.location!.address!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.address.tr(),
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.white),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.location!.address!,
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: ColorManager.white),
                    ),
                  ],
                ),

              SizedBox(height: 16.h),

              Row(
                children: [
                  if (item.travelMinutes != null)
                    _buildCustomButton(
                      icon: IconManager.car,
                      text: item.travelMinutes! > 60
                          ? "${item.travelMinutes! / 60} ${LocaleKeys.hours.tr()}"
                          : "${(item.travelMinutes! + 3).toStringAsFixed(1)} ${LocaleKeys.minutes.tr()}",
                      context: context,
                    ),
                  if (item.travelMinutes != null) 8.horizontalSpace,

                  _buildCustomButton(
                    text: LocaleKeys.more.tr(),
                    onTap: () =>
                        context.router.push(CategoryItemDetialsRoute(subCategoryId: item.main!, itemId: item.id)),
                    context: context,
                  ),
                ],
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton({String? icon, VoidCallback? onTap, required String text, required BuildContext context}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(color: ColorManager.white, borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                SvgPicture.asset(icon, colorFilter: ColorFilter.mode(ColorManager.black, BlendMode.srcIn)),
                SizedBox(width: 6.w),
              ],
              Text(text, style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.black)),
            ],
          ),
        ),
      ),
    );
  }
}
