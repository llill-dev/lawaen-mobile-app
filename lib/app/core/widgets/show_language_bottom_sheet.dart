import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';

void showLanguageBottomSheet({
  required BuildContext context,
  required List<String> options,
  required String selectedOption,
  required String title,
  required Function(String) onSelect,
}) {
  String currentSelection = selectedOption;

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    enableDrag: true,
    backgroundColor: ColorManager.white,
    builder: (bottomSheetContext) {
      return BlocBuilder<RefreshCubit, dynamic>(
        bloc: getIt<RefreshCubit>(),
        builder: (ctx, state) {
          return Padding(
            padding: REdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.verticalSpace,
                Center(
                  child: Container(
                    width: 94.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: ColorManager.blackSwatch[5],
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                4.verticalSpace,

                /// ---- Title ----
                Text(title, style: Theme.of(context).textTheme.bodyMedium),

                12.verticalSpace,

                /// ---- Options ----
                ...options.map((option) {
                  bool isSelected = currentSelection == option;

                  return GestureDetector(
                    onTap: () {
                      currentSelection = option;

                      onSelect(option);
                    },
                    child: Container(
                      margin: REdgeInsets.only(bottom: 8),
                      padding: REdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: ColorManager.blackSwatch[3],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? ColorManager.green : ColorManager.grey,
                          ),
                          10.horizontalSpace,
                          Text(option, style: Theme.of(context).textTheme.headlineMedium),
                        ],
                      ),
                    ),
                  );
                }),

                16.verticalSpace,
              ],
            ),
          );
        },
      );
    },
  );
}
