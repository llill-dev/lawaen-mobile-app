import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_missing_place_cubit/add_missing_place_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/working_hours.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/conditions_widget.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/claim_and_im_not_robort_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/we_dont_collect_data_text.dart';

class MissingWorkingReviewStep extends StatelessWidget {
  const MissingWorkingReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WorkingHours(),
        const SizedBox(height: 24),
        BlocBuilder<AddMissingPlaceFormCubit, AddMissingPlaceFormState>(
          builder: (context, state) {
            final acceptOptions = state.params.acceptOptions;
            final cubit = context.read<AddMissingPlaceFormCubit>();
            return ConditionsWidget(
              acceptOne: acceptOptions.acceptOne ?? false,
              acceptTwo: acceptOptions.acceptTwo ?? false,
              acceptThree: acceptOptions.acceptThree ?? false,
              onAcceptOneChanged: cubit.updateAcceptOne,
              onAcceptTwoChanged: cubit.updateAcceptTwo,
              onAcceptThreeChanged: cubit.updateAcceptThree,
            );
          },
        ),
        const SizedBox(height: 24),
        const ClaimAndImNotRobortButtons(),
        const SizedBox(height: 24),
        const WeDontCollectDataText(),
        const SizedBox(height: 24),
      ],
    );
  }
}
