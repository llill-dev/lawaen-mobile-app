import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/resources/language_manager.dart';

class SectionSelector extends StatelessWidget {
  final int selectedIndex;
  final List<String> sections;
  final ValueChanged<int> onSectionSelected;
  final bool haveMuneTap;

  const SectionSelector({
    super.key,
    required this.selectedIndex,
    required this.onSectionSelected,
    required this.sections,
    this.haveMuneTap = false,
  });

  /// 🔹 Measure text width accurately
  double _textWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    final lang = getIt<AppPreferences>().getAppLanguage();
    final textStyle = Theme.of(context).textTheme.displaySmall!;
    final tb = haveMuneTap ? 8 : 12;

    return SliverToBoxAdapter(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = (constraints.maxWidth / sections.length) - tb;

          final selectedText = sections[selectedIndex];
          final textWidth = _textWidth(selectedText, textStyle);
          final indicatorWidth = textWidth * 2;

          final indicatorOffset = (tabWidth * selectedIndex) + (tabWidth - indicatorWidth) / 2;

          return Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withValues(alpha: .25),
                  blurRadius: 13,
                  offset: const Offset(-3, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Row(
                  children: List.generate(sections.length, (index) {
                    return Expanded(
                      child: _SectionItem(
                        title: sections[index],
                        isSelected: index == selectedIndex,
                        onTap: () => onSectionSelected(index),
                      ),
                    );
                  }),
                ),

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  left: lang == english ? indicatorOffset : null,
                  right: lang == arabic ? indicatorOffset : null,
                  bottom: 0,
                  child: Container(
                    width: indicatorWidth,
                    height: 2.h,
                    decoration: BoxDecoration(color: ColorManager.green, borderRadius: BorderRadius.circular(2.r)),
                  ),
                ),
              ],
            ),
          ).horizontalPadding(padding: 16.w);
        },
      ),
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
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            // color: isSelected ? ColorManager.primary.withValues(alpha: 0.1) : ColorManager.white,
            // borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(color: isSelected ? ColorManager.green : ColorManager.primary),
          ),
        ),
      ),
    );
  }
}
