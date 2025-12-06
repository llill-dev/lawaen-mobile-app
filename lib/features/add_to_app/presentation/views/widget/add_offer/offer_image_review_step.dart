import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_offer_cubit/add_offer_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/upload_image.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/conditions_widget.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/claim_and_im_not_robort_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/we_dont_collect_data_text.dart';

class OfferImageReviewStep extends StatelessWidget {
  const OfferImageReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AddOfferFormCubit, AddOfferFormState>(
          builder: (context, state) {
            return UploadImage(
              imageFile: state.params.imageFile,
              onImageSelected: (file) {
                context.read<AddOfferFormCubit>().updateImage(file);
              },
            );
          },
        ),
        SizedBox(height: 24),
        BlocBuilder<AddOfferFormCubit, AddOfferFormState>(
          builder: (context, state) {
            final acceptOptions = state.params.acceptOptions;
            final cubit = context.read<AddOfferFormCubit>();
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
        SizedBox(height: 24),
        ClaimAndImNotRobortButtons(),
        SizedBox(height: 24),
        WeDontCollectDataText(),
        SizedBox(height: 24),
      ],
    );
  }
}
