import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class AddToAppBottomButtons extends StatelessWidget {
  const AddToAppBottomButtons({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.onPreviousPressed,
    required this.onNextPressed,
    this.isLoading = false,
  });

  final bool isFirst;
  final bool isLast;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isFirst)
          Expanded(
            child: PrimaryButton(
              onPressed: onPreviousPressed,
              text: LocaleKeys.previous.tr(),
              backgroundColor: ColorManager.lightGrey,
              borederColor: ColorManager.lightGrey,
              textColor: ColorManager.black,
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorManager.black, size: 16.r),
            ),
          ),
        if (!isFirst) 12.horizontalSpace,
        Expanded(
          child: PrimaryButton(
            onPressed: onNextPressed,
            isLoading: isLoading,
            text: isLast ? LocaleKeys.submit.tr() : LocaleKeys.next.tr(),
            isIconOnLeft: false,
            icon: Icon(Icons.arrow_forward_ios_rounded, color: ColorManager.white, size: 16.r),
          ),
        ),
      ],
    );
  }
}
