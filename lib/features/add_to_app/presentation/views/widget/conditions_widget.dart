import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class CheckBoxRow extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool?)? onChanged;
  const CheckBoxRow({super.key, required this.title, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: ColorManager.primary,
          activeColor: ColorManager.blackSwatch[3],
        ),
        4.horizontalSpace,
        Flexible(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.blackSwatch[12]),
          ),
        ),
      ],
    );
  }
}

class ConditionsWidget extends StatelessWidget {
  final bool acceptOne;
  final bool acceptTwo;
  final bool acceptThree;
  final ValueChanged<bool> onAcceptOneChanged;
  final ValueChanged<bool> onAcceptTwoChanged;
  final ValueChanged<bool> onAcceptThreeChanged;

  const ConditionsWidget({
    super.key,
    required this.acceptOne,
    required this.acceptTwo,
    required this.acceptThree,
    required this.onAcceptOneChanged,
    required this.onAcceptTwoChanged,
    required this.onAcceptThreeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          CheckBoxRow(
            title: LocaleKeys.acceptTerms.tr(),
            value: acceptOne,
            onChanged: (value) => onAcceptOneChanged(value ?? false),
          ),
          8.verticalSpace,
          CheckBoxRow(
            title: LocaleKeys.reviewSubscriptionCost.tr(),
            value: acceptTwo,
            onChanged: (value) => onAcceptTwoChanged(value ?? false),
          ),
          8.verticalSpace,
          CheckBoxRow(
            title: LocaleKeys.informationCorrect.tr(),
            value: acceptThree,
            onChanged: (value) => onAcceptThreeChanged(value ?? false),
          ),
        ],
      ),
    );
  }
}
