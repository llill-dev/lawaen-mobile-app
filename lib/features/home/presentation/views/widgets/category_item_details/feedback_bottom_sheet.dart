import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/presentation/cubit/category_item_details_cubit/category_item_detials_cubit.dart';
import 'package:lawaen/features/home/presentation/params/rate_item_params.dart';
import 'package:lawaen/features/home/presentation/params/send_feed_back_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import '../../../../../../app/core/widgets/primary_button.dart';

class FeedbackBottomSheet extends StatefulWidget {
  final String categoryId;
  final String itemId;
  final bool isRated;

  const FeedbackBottomSheet({super.key, required this.categoryId, required this.itemId, required this.isRated});

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  int selectedRating = 0;

  final TextEditingController _controller = TextEditingController();
  final cubit = getIt<CategoryItemDetialsCubit>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16.w, right: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isRated)
              BlocConsumer<CategoryItemDetialsCubit, CategoryItemDetialsState>(
                bloc: cubit,
                listenWhen: (prev, curr) => prev.rateItemState != curr.rateItemState,
                listener: (context, state) {
                  if (state.rateItemState == RequestState.error) {
                    showToast(message: state.rateItemError ?? LocaleKeys.defaultError.tr(), isError: true);
                  }
                  if (state.rateItemState == RequestState.success) {
                    Navigator.pop(context);
                    _controller.clear();
                  }
                },
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          final isSelected = index < selectedRating;
                          return GestureDetector(
                            onTap: state.rateItemState == RequestState.loading
                                ? null
                                : () {
                                    setState(() {
                                      selectedRating = index + 1;
                                    });
                                  },
                            child: Icon(
                              Icons.star_rounded,
                              size: 28.r,
                              color: isSelected ? ColorManager.orange : ColorManager.darkGrey,
                            ),
                          );
                        }),
                      ),
                      PrimaryButton(
                        width: 60.w,
                        height: 45.w,
                        borderRadius: 12,
                        text: LocaleKeys.rate.tr(),
                        isLoading: state.rateItemState == RequestState.loading,
                        onPressed: selectedRating == 0
                            ? null
                            : () {
                                cubit.rateItem(
                                  itemId: widget.itemId,
                                  secondCategoryId: widget.categoryId,
                                  params: RateItemParams(rating: selectedRating),
                                );
                              },
                      ),
                    ],
                  );
                },
              ),

            if (!widget.isRated) 16.verticalSpace,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.writeYourFeedback.tr(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.orange),
                ),
                GestureDetector(
                  onTap: () => context.router.push(FeedbackRoute()),
                  child: Text(
                    LocaleKeys.seeAll.tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.black),
                  ),
                ),
              ],
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
                controller: _controller,
                maxLines: null,
                expands: true,
                style: Theme.of(context).textTheme.headlineMedium,
                decoration: InputDecoration(
                  hintText: LocaleKeys.writeYourFeedbackHint.tr(),
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
              listenWhen: (prev, curr) => prev.sendFeedBackState != curr.sendFeedBackState,
              listener: (context, state) {
                if (state.sendFeedBackState == RequestState.success) {
                  showToast(message: LocaleKeys.feedbackSubmittedSuccessfully.tr(), isSuccess: true);
                  Navigator.pop(context);
                  _controller.clear();
                }

                if (state.sendFeedBackState == RequestState.error) {
                  showToast(message: state.sendFeedBackError ?? LocaleKeys.defaultError.tr(), isError: true);
                }
              },
              builder: (context, state) {
                return Center(
                  child: PrimaryButton(
                    text: LocaleKeys.send.tr(),
                    width: 150.w,
                    isLoading: state.sendFeedBackState == RequestState.loading,
                    onPressed: () {
                      final feedback = _controller.text.trim();

                      if (feedback.isEmpty) {
                        showToast(message: LocaleKeys.feedbackMessageRequired.tr(), isError: true);
                        return;
                      }

                      cubit.sendFeedBack(
                        itemId: widget.itemId,
                        secondCategoryId: widget.categoryId,
                        params: SendFeedBackParams(message: feedback),
                      );
                    },
                  ),
                );
              },
            ),

            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
