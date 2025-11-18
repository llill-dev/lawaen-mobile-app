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
  const TextFiledItem({
    super.key,
    required this.title,
    this.maxLines,
    this.withTitle = true,
    this.controller,
    this.hintText,
    this.readOnly,
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
          hint: hintText ?? title,
          readOnly: readOnly ?? false,
          fillColor: ColorManager.blackSwatch[3],
          horizontalContentPadding: 8.w,
          verticalContentPadding: 10.h,
          borderWidth: 2,
          maxLines: maxLines ?? 1,
          controller: controller,
        ),
      ],
    ).horizontalPadding(padding: withTitle ? 16.w : 0);
  }
}
