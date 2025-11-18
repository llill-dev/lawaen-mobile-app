import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'recent_search.dart';

class ExploreHeaderSection extends StatelessWidget {
  const ExploreHeaderSection({super.key, required this.isGridView, required this.onViewModeChanged});

  final bool isGridView;
  final ValueChanged<bool> onViewModeChanged;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 0.1),
              offset: const Offset(0, 1),
              spreadRadius: -1,
              blurRadius: 2,
            ),
            BoxShadow(color: ColorManager.black.withValues(alpha: 0.1), offset: const Offset(0, 1), blurRadius: 3),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.explore.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 24)),
                Row(
                  children: [
                    buildDisplayIcon(
                      isSelected: isGridView,
                      icon: IconManager.gridIcon,
                      onTap: () => onViewModeChanged(true),
                    ),
                    8.horizontalSpace,
                    buildDisplayIcon(
                      isSelected: !isGridView,
                      icon: IconManager.listIcon,
                      onTap: () => onViewModeChanged(false),
                    ),
                  ],
                ),
              ],
            ),
            16.verticalSpace,
            CustomTextField(
              hint: LocaleKeys.search_for_places_and_services.tr(),
              fillColor: ColorManager.blackSwatch[3],
              borderColor: ColorManager.blackSwatch[3],
              verticalContentPadding: 14.h,
              prefixIcon: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset(IconManager.search)),
            ),
            16.verticalSpace,
            RecentSearch(),
          ],
        ),
      ),
    );
  }

  Widget buildDisplayIcon({required bool isSelected, required String icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(
          icon,
          colorFilter: isSelected ? ColorFilter.mode(ColorManager.white, BlendMode.srcIn) : null,
        ),
      ),
    );
  }
}
