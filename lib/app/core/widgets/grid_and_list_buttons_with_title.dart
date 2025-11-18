import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class GridAndListButtonsWithTitle extends StatelessWidget {
  final bool isGridView;
  final ValueChanged<bool> onViewModeChanged;
  final String title;
  const GridAndListButtonsWithTitle({
    super.key,
    required this.isGridView,
    required this.onViewModeChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 24)),
        Row(
          children: [
            buildDisplayIcon(isSelected: isGridView, icon: IconManager.gridIcon, onTap: () => onViewModeChanged(true)),
            8.horizontalSpace,
            buildDisplayIcon(
              isSelected: !isGridView,
              icon: IconManager.listIcon,
              onTap: () => onViewModeChanged(false),
            ),
          ],
        ),
      ],
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
