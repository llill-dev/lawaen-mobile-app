import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class DropDownItem extends StatelessWidget {
  final String title;
  final String? hit;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final bool withTitle;
  final String? initialValue;
  final String Function(String value)? itemLabelBuilder;
  const DropDownItem({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.withTitle = true,
    this.hit,
    this.initialValue,
    this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveInitialValue = initialValue != null && items.contains(initialValue) ? initialValue : null;
    final dropdownKey = ValueKey<String>('${effectiveInitialValue ?? 'empty'}-${items.join('|')}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withTitle)
          Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.primary)),
        8.verticalSpace,
        Theme(
          data: Theme.of(context).copyWith(
            highlightColor: ColorManager.primary.withValues(alpha: 0.3),
            hoverColor: ColorManager.primary.withValues(alpha: 0.15),
            splashColor: Colors.transparent,
          ),
          child: DropdownButtonFormField(
            key: dropdownKey,
            dropdownColor: ColorManager.blackSwatch[2],
            borderRadius: BorderRadius.circular(24.r),
            decoration: InputDecoration(
              fillColor: ColorManager.blackSwatch[2],
              hint: Text(
                hit ?? title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.blackSwatch[6]),
              ),
              filled: true,
              contentPadding: REdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(width: 2, color: ColorManager.blackSwatch[4]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(width: 2, color: ColorManager.blackSwatch[4]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(width: 2, color: ColorManager.blackSwatch[4]!),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(width: 1, color: ColorManager.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(width: 2, color: ColorManager.blackSwatch[4]!),
              ),
            ),

            initialValue: effectiveInitialValue,
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(itemLabelBuilder?.call(e) ?? e))).toList(),
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
          ),
        ),
      ],
    ).horizontalPadding(padding: withTitle ? 16.w : 0);
  }
}
