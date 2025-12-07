import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_offer_cubit/add_offer_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_offer/offer_basic_info_step.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_offer/offer_contact_info_step.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_offer/offer_image_review_step.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_to_app_bottom_buttons.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/steps_header.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'widget/add_app_bar.dart';

@RoutePage()
class AddOfferScreen extends StatelessWidget {
  const AddOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddOfferFormCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<AddOfferFormCubit, AddOfferFormState>(
              builder: (context, state) {
                final cubit = context.read<AddOfferFormCubit>();
                final isFirst = state.currentStep == 0;
                final isLast = state.currentStep == AddOfferFormCubit.totalSteps - 1;

                final steps = [
                  LocaleKeys.basicInformation.tr(),
                  LocaleKeys.contactInformation.tr(),
                  LocaleKeys.image.tr(),
                ];

                return Column(
                  children: [
                    AddAppBar(title: LocaleKeys.addClassifiedActionTitle.tr()),
                    const SizedBox(height: 32),

                    StepsHeader(currentStep: state.currentStep, titles: steps),

                    const SizedBox(height: 24),

                    AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: _buildStep(state.currentStep)),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: AddToAppBottomButtons(
                        isFirst: isFirst,
                        isLast: isLast,
                        onPreviousPressed: () {
                          cubit.previousStep();
                        },
                        onNextPressed: () {
                          if (isLast) {
                            // TODO: submit using cubit.state
                            // For now just print or show dialog
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

  Widget _buildStep(int index) {
    switch (index) {
      case 0:
        return const OfferBasicInfoStep();
      case 1:
        return const OfferContactInfoStep();
      case 2:
        return const OfferImageReviewStep();
      default:
        return const SizedBox.shrink();
    }
  }
}
