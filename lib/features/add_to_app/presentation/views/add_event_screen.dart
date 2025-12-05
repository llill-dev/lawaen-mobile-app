import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_event_cubit/add_event_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_app_bar.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_event/event_basic_info_stpe.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_event/event_booking_details_stpe.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_event/event_contact_info_stpe.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_event/event_image_location_step.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_event/event_working_hours_screen.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_to_app_bottom_buttons.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/steps_header.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddEventFormCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              children: [
                AddAppBar(title: LocaleKeys.addEventTitle.tr()),
                32.verticalSpace,

                BlocBuilder<AddEventFormCubit, AddEventFormState>(
                  builder: (context, state) {
                    final stepsTitles = [
                      LocaleKeys.basicInformation.tr(),
                      LocaleKeys.contactInformation.tr(),
                      LocaleKeys.bookingDetails.tr(),
                      LocaleKeys.imageAndLocation.tr(),
                      LocaleKeys.workingTimeAndReview.tr(),
                    ];

                    return StepsHeader(currentStep: state.currentStep, titles: stepsTitles);
                  },
                ),

                // BODY (steps)
                BlocBuilder<AddEventFormCubit, AddEventFormState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        final offsetAnimation = Tween<Offset>(
                          begin: const Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(animation);
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(position: offsetAnimation, child: child),
                        );
                      },
                      child: _buildStep(state.currentStep),
                    );
                  },
                ),

                // BOTTOM BUTTONS
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: BlocBuilder<AddEventFormCubit, AddEventFormState>(
                    builder: (context, state) {
                      final cubit = context.read<AddEventFormCubit>();
                      final isFirst = state.currentStep == 0;
                      final isLast = state.currentStep == AddEventFormCubit.totalSteps - 1;

                      return AddToAppBottomButtons(
                        isFirst: isFirst,
                        onNextPressed: () {
                          if (isLast) {
                            // TODO: submit using cubit.state
                            // For now just print or show dialog
                          } else {
                            cubit.nextStep();
                          }
                        },
                        onPreviousPressed: () {
                          cubit.previousStep();
                        },
                        isLast: isLast,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int currentStep) {
    switch (currentStep) {
      case 0:
        return const EventBasicInfoStpe(key: ValueKey('basic'));
      case 1:
        return const EventContactInfoStep(key: ValueKey('contact'));
      case 2:
        return const EventBookingDetailsStep(key: ValueKey('booking'));
      case 3:
        return const EventImageLocationStep(key: ValueKey('image_location'));
      case 4:
        return const EventWorkingReviewStep(key: ValueKey('working_review'));
      default:
        return const SizedBox.shrink();
    }
  }
}
