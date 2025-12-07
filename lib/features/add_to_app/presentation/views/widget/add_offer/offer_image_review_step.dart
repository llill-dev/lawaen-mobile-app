import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_offer_cubit/add_offer_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/recaptch_check_box.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/upload_image.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/conditions_widget.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/we_dont_collect_data_text.dart';

class OfferImageReviewStep extends StatelessWidget {
  const OfferImageReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddOfferFormCubit>();

    return BlocBuilder<AddOfferFormCubit, AddOfferFormState>(
      builder: (context, state) {
        final params = state.params;

        return Column(
          children: [
            UploadImage(imageFile: params.imageFile, onImageSelected: cubit.updateImage),
            const SizedBox(height: 24),

            ConditionsWidget(
              acceptOne: params.acceptOptions.acceptOne ?? false,
              acceptTwo: params.acceptOptions.acceptTwo ?? false,
              acceptThree: params.acceptOptions.acceptThree ?? false,
              onAcceptOneChanged: cubit.updateAcceptOne,
              onAcceptTwoChanged: cubit.updateAcceptTwo,
              onAcceptThreeChanged: cubit.updateAcceptThree,
            ),

            const SizedBox(height: 24),

            RecaptchaCheckbox(
              value: params.recaptcha,
              onChanged: cubit.updateRecaptcha,
            ).horizontalPadding(padding: 16.w),

            const SizedBox(height: 24),
            const WeDontCollectDataText(),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}
