import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class AuthTextFieldItem extends StatelessWidget {
  final String title;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const AuthTextFieldItem({
    super.key,
    required this.title,
    required this.hint,
    required this.prefixIcon,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.black)),
        12.verticalSpace,
        CustomTextField(
          controller: controller,
          validator: validator,
          fillColor: ColorManager.blackSwatch[3],
          borderColor: ColorManager.blackSwatch[3],
          verticalContentPadding: 12.h,
          hint: hint,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Icon(prefixIcon, color: ColorManager.grey, size: 19.r),
          ),
        ),
      ],
    );
  }
}
