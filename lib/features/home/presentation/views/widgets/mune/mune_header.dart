import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> preferences = [
      {'title': 'Vegan', 'icon': IconManager.mune},
      {'title': 'Vegetarian', 'icon': IconManager.mune},
      {'title': 'Gluten-Free', 'icon': IconManager.mune},
      {'title': 'Low Carb', 'icon': IconManager.mune},
      {'title': 'Keto', 'icon': IconManager.mune},
    ];
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: .25),
              spreadRadius: -1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hint: "Search menu items...",
              fillColor: ColorManager.lightGrey.withValues(alpha: .8),
              verticalContentPadding: 8.w,
              prefixIcon: Padding(padding: EdgeInsets.all(10.w), child: SvgPicture.asset(IconManager.search)),
            ),
            12.verticalSpace,
            Text("Dietary Preferences:", style: Theme.of(context).textTheme.headlineMedium),
            12.verticalSpace,
            Wrap(
              spacing: 8.w,
              children: preferences
                  .map((item) => buildChipItem(title: item['title']!, icon: item['icon']!, context: context))
                  .toList(),
            ),
          ],
        ),
      ).horizontalPadding(padding: 16.w),
    );
  }

  Widget buildChipItem({required String title, required String icon, required BuildContext context}) {
    return IntrinsicWidth(
      child: Chip(
        backgroundColor: ColorManager.white,
        side: BorderSide(color: ColorManager.borderColor),
        labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon, width: 12.w, height: 12.w),
            4.horizontalSpace,
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.black, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
