import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class RecaptchaCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RecaptchaCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: ColorManager.white,
        border: Border.all(color: ColorManager.primary, width: 2),
        boxShadow: [
          BoxShadow(color: ColorManager.primary.withValues(alpha: 0.3), blurRadius: 3.r, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            checkColor: ColorManager.primary,
            activeColor: ColorManager.blackSwatch[3],
            onChanged: (v) => onChanged(v ?? false),
          ),
          Text(LocaleKeys.imNotRobot.tr(), style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
