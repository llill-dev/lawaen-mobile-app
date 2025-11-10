import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class SectionSelector extends StatelessWidget {
  final List<String> sections;
  final int selectedIndex;
  final ValueChanged<int> onSectionSelected;

  const SectionSelector({
    super.key,
    required this.sections,
    required this.selectedIndex,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 13, offset: const Offset(-3, 4)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(sections.length, (index) {
            return _SectionItem(
              title: sections[index],
              isSelected: index == selectedIndex,
              onTap: () => onSectionSelected(index),
            );
          }),
        ),
      ).horizontalPadding(padding: 16.w),
    );
  }
}

class _SectionItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SectionItem({required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary.withValues(alpha: 0.1) : ColorManager.white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: isSelected ? ColorManager.primary : ColorManager.darkGrey),
        ),
      ),
    );
  }
}
