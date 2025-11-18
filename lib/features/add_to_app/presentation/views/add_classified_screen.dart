import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_service_or_mune.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_to_app_form.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/claim_and_im_not_robort_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/conditions_widget.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/determine_location.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/note_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/upload_file.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/we_dont_collect_data_text.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/working_hours.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'widget/add_app_bar.dart';

@RoutePage()
class AddClassifiedScreen extends StatelessWidget {
  const AddClassifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              AddAppBar(title: LocaleKeys.addClassifiedTitle.tr()),
              24.verticalSpace,
              NoteContainer(
                note: LocaleKeys.addClassifiedNote.tr(),
              ),
              24.verticalSpace,
              AddToAppForm(isClassified: true),
              24.verticalSpace,
              UploadFile(),
              24.verticalSpace,
              DetermineLocation(),
              24.verticalSpace,
              WorkingHours(),
              24.verticalSpace,
              AddServiceOrMune(),
              24.verticalSpace,
              ConditionsWidget(),
              24.verticalSpace,
              ClaimAndImNotRobortButtons(),
              24.verticalSpace,
              PrimaryButton(text: LocaleKeys.submit.tr(), onPressed: () {}, withShadow: true),
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
