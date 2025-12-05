import 'package:flutter/material.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/upload_file.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/conditions_widget.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/claim_and_im_not_robort_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/we_dont_collect_data_text.dart';

class OfferImageReviewStep extends StatelessWidget {
  const OfferImageReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        UploadFile(),
        SizedBox(height: 24),
        ConditionsWidget(),
        SizedBox(height: 24),
        ClaimAndImNotRobortButtons(),
        SizedBox(height: 24),
        WeDontCollectDataText(),
        SizedBox(height: 24),
      ],
    );
  }
}
