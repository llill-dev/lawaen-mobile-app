import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class DropDownItem extends StatelessWidget {
  final String title;
  final String? hit;
  final List<String> items;
  final Function(String)? onChanged;
  final bool withTitle;
  const DropDownItem({
    super.key,
    required this.title,
    required this.items,
    this.onChanged,
    this.withTitle = true,
    this.hit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withTitle)
          Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.primary)),
        8.verticalSpace,
        DropdownButtonFormField(
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
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) => onChanged?.call(value!),
        ),
      ],
    ).horizontalPadding(padding: withTitle ? 16.w : 0);
  }
}
