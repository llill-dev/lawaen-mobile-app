import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/category_item_details_cubit/category_item_detials_cubit.dart';
import 'package:lawaen/features/home/presentation/params/report_item_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class ReportBottomSheet extends StatelessWidget {
  final String itemId;
  final String categoryId;
  const ReportBottomSheet({super.key, required this.itemId, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<CategoryItemDetialsCubit>();
    final controller = TextEditingController();
    return Padding(
      padding: EdgeInsetsGeometry.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.writeYourReportMessage.tr(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
          ),

          16.verticalSpace,

          Container(
            height: 120.h,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: ColorManager.white,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withValues(alpha: .25),
                  blurRadius: 13,
                  offset: const Offset(-3, 4),
                ),
              ],
              border: Border.all(color: ColorManager.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: InputDecoration(
                hintText: LocaleKeys.writeYourReportMessageHint.tr(),
                hintStyle: Theme.of(context).textTheme.headlineSmall,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),

          24.verticalSpace,

          BlocConsumer<CategoryItemDetialsCubit, CategoryItemDetialsState>(
            bloc: cubit,
            listener: (context, state) {
              if (state.reportItemState == RequestState.success) {
                showToast(message: LocaleKeys.reportSubmittedSurccessfully.tr(), isSuccess: true);
                Navigator.pop(context);
                controller.clear();
              }

              if (state.reportItemState == RequestState.error) {
                showToast(message: state.reportItemError ?? LocaleKeys.defaultError.tr(), isError: true);
              }
            },
            builder: (context, state) {
              return Center(
                child: PrimaryButton(
                  isLight: true,
                  text: LocaleKeys.send.tr(),
                  width: 150.w,
                  isLoading: state.reportItemState == RequestState.loading,
                  onPressed: () {
                    final reportMsg = controller.text.trim();

                    if (reportMsg.isEmpty) {
                      showToast(message: LocaleKeys.reportMessageRequired.tr(), isError: true);
                      return;
                    }

                    cubit.reportItem(
                      itemId: itemId,
                      secondCategoryId: categoryId,
                      params: ReportItemParams(message: reportMsg),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
