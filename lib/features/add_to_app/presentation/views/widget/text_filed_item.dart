import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class TextFiledItem extends StatelessWidget {
  final String title;
  final int? maxLines;
  final bool withTitle;
  final String? hintText;
  final bool? readOnly;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final bool withHint;
  final VoidCallback? onTap;
  const TextFiledItem({
    super.key,
    required this.title,
    this.maxLines,
    this.withTitle = true,
    this.controller,
    this.hintText,
    this.readOnly,
    this.onChanged,
    this.fillColor,
    this.keyboardType,
    this.onTap,
    this.withHint = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withTitle)
          Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.primary)),
        8.verticalSpace,
        CustomTextField(
          hint: withHint ? hintText ?? title : null,
          readOnly: readOnly ?? false,
          fillColor: fillColor ?? ColorManager.blackSwatch[2],
          horizontalContentPadding: 8.w,
          verticalContentPadding: 10.h,
          borderWidth: 2,
          maxLines: maxLines ?? 1,
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          onTap: onTap,
        ),
      ],
    ).horizontalPadding(padding: withTitle ? 16.w : 0);
  }
}
