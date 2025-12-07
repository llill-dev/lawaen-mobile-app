import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/app_time_picker_field.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_missing_place_cubit/add_missing_place_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/conditions_widget.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/we_dont_collect_data_text.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class MissingWorkingReviewStep extends StatelessWidget {
  const MissingWorkingReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMissingPlaceFormCubit, AddMissingPlaceFormState>(
      builder: (context, state) {
        final cubit = context.read<AddMissingPlaceFormCubit>();
        final params = state.params;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --------------------------
              // OPEN & CLOSE TIME
              // --------------------------
              Text(LocaleKeys.workingTime.tr(), style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 12.h),

              Row(
                children: [
                  Expanded(
                    child: AppTimePickerField(
                      title: LocaleKeys.openTime.tr(),
                      value: params.openTime,
                      hint: "00:00",
                      onTimeSelected: (t) {
                        final time = "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
                        cubit.updateOpenTime(time);
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppTimePickerField(
                      title: LocaleKeys.closeTime.tr(),
                      value: params.closeTime,
                      hint: "00:00",
                      onTimeSelected: (t) {
                        final time = "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
                        cubit.updateCloseTime(time);
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // --------------------------
              // ACCEPT OPTIONS
              // --------------------------
              ConditionsWidget(
                acceptOne: params.acceptOptions.acceptOne ?? false,
                acceptTwo: params.acceptOptions.acceptTwo ?? false,
                acceptThree: params.acceptOptions.acceptThree ?? false,
                onAcceptOneChanged: cubit.updateAcceptOne,
                onAcceptTwoChanged: cubit.updateAcceptTwo,
                onAcceptThreeChanged: cubit.updateAcceptThree,
              ),

              SizedBox(height: 24.h),

              // --------------------------
              // RECAPTCHA CHECK (CUBIT)
              // --------------------------
              _RecaptchaCheckbox(value: params.recaptcha, onChanged: cubit.updateRecaptcha),

              SizedBox(height: 24.h),
              const WeDontCollectDataText(),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }
}

class _RecaptchaCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _RecaptchaCheckbox({required this.value, required this.onChanged});

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
