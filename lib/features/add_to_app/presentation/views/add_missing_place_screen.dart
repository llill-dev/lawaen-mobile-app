import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_missing_place_cubit/add_missing_place_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_to_app_bottom_buttons.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/steps_header.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'widget/add_app_bar.dart';
import 'widget/add_missing_place/missing_basic_info_step.dart';
import 'widget/add_missing_place/missing_contact_info_step.dart';
import 'widget/add_missing_place/missing_image_location_step.dart';
import 'widget/add_missing_place/missing_working_review_step.dart';

@RoutePage()
class AddMissingPlaceScreen extends StatelessWidget {
  const AddMissingPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddMissingPlaceFormCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: BlocConsumer<AddMissingPlaceFormCubit, AddMissingPlaceFormState>(
              listener: (context, state) {
                if (state.submitError != null || state.submitState == RequestState.error) {
                  showToast(message: state.submitError!, isError: true);
                }
                if (state.submitState == RequestState.success) {
                  showToast(message: LocaleKeys.addedSuccessfully.tr(), isSuccess: true);
                  context.pop();
                }
              },
              builder: (context, state) {
                final cubit = context.read<AddMissingPlaceFormCubit>();
                final isFirst = state.currentStep == 0;
                final isLast = state.currentStep == AddMissingPlaceFormCubit.totalSteps - 1;

                final titles = [
                  LocaleKeys.basicInformation.tr(),
                  LocaleKeys.contactInformation.tr(),
                  LocaleKeys.imageAndLocation.tr(),
                  LocaleKeys.workingTimeAndReview.tr(),
                ];

                return Column(
                  children: [
                    AddAppBar(title: LocaleKeys.addMissingPlaceActionTitle.tr()),
                    const SizedBox(height: 32),

                    StepsHeader(currentStep: state.currentStep, titles: titles),

                    AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: _buildStep(state.currentStep)),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: AddToAppBottomButtons(
                        isFirst: isFirst,
                        isLast: isLast,
                        isLoading: state.submitState == RequestState.loading,
                        onPreviousPressed: () {
                          cubit.previousStep();
                        },
                        onNextPressed: () {
                          final cubit = context.read<AddMissingPlaceFormCubit>();

                          if (!cubit.validateStep(state.currentStep)) return;

                          if (isLast) {
                            cubit.submit();
                          } else {
                            cubit.nextStep();
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int current) {
    switch (current) {
      case 0:
        return const MissingBasicInfoStep();
      case 1:
        return const MissingContactInfoStep();
      case 2:
        return const MissingImageLocationStep();
      case 3:
        return const MissingWorkingReviewStep();
      default:
        return const SizedBox.shrink();
    }
  }
}
