import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_to_app_form.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/claim_and_im_not_robort_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/conditions_widget.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/determine_location.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/note_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/upload_file.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/we_dont_collect_data_text.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/working_hours.dart';

import 'widget/add_app_bar.dart';

@RoutePage()
class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              AddAppBar(title: "Add Event"),
              24.verticalSpace,
              NoteContainer(
                note:
                    "Please note that this service is paid.After you fill in your information, our team will contact you.",
              ),
              24.verticalSpace,
              AddToAppForm(isEvent: true),
              24.verticalSpace,
              UploadFile(),
              24.verticalSpace,
              DetermineLocation(),
              24.verticalSpace,
              WorkingHours(),
              24.verticalSpace,
              ConditionsWidget(),
              24.verticalSpace,
              ClaimAndImNotRobortButtons(),
              24.verticalSpace,
              PrimaryButton(text: "submit", onPressed: () {}, withShadow: true),
              24.verticalSpace,
              WeDontCollectDataText(),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
