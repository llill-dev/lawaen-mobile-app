import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/claim_and_im_not_robort_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/conditions_widget.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/we_dont_collect_data_text.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/working_hours.dart';

class EventWorkingReviewStep extends StatelessWidget {
  const EventWorkingReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.verticalSpace,
        const WorkingHours(),
        24.verticalSpace,
        const ConditionsWidget(),
        24.verticalSpace,
        const ClaimAndImNotRobortButtons(),
        24.verticalSpace,
        const WeDontCollectDataText(),
        24.verticalSpace,
      ],
    );
  }
}
