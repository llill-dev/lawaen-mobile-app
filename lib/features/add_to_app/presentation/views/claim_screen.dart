import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_services/no_item_container.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class ClaimScreen extends StatelessWidget {
  const ClaimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  LocaleKeys.claimFormMessage.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: ColorManager.primary),
                ).horizontalPadding(padding: 16.w),
              ),
              24.verticalSpace,
              ClaimForm(),
              24.verticalSpace,
              Text(
                LocaleKeys.claimDocuments.tr(namedArgs: {'count': '0'}),
                style: Theme.of(context).textTheme.headlineMedium,
              ).horizontalPadding(padding: 16.w),
              24.verticalSpace,
              NoItemAddedContainer(title: LocaleKeys.noMenuItemsYet.tr()),
              24.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(onPressed: () {}, text: LocaleKeys.save.tr()),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: PrimaryButton(
                      text: LocaleKeys.cancel.tr(),
                      backgroundColor: ColorManager.white,
                      textColor: ColorManager.primary,
                      borederColor: ColorManager.primary,
                      onPressed: () {},
                    ),
                  ),
                ],
              ).horizontalPadding(padding: 16.w),
            ],
          ),
        ),
      ),
    );
  }
}

class ClaimForm extends StatelessWidget {
  const ClaimForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: ColorManager.black.withValues(alpha: 0.25), offset: const Offset(0, 2), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          ClaimTextFiledItem(
            title: LocaleKeys.claimUserName.tr(),
            hint: LocaleKeys.claimUserNameHint.tr(),
            icon: Icons.person_outline,
          ),
          12.verticalSpace,
          ClaimTextFiledItem(
            title: LocaleKeys.emailAddress.tr(),
            hint: LocaleKeys.claimEmailHint.tr(),
            icon: Icons.email_outlined,
          ),
          12.verticalSpace,
          ClaimTextFiledItem(
            title: LocaleKeys.claimAddress.tr(),
            hint: LocaleKeys.claimAddressHint.tr(),
            icon: Icons.location_on_outlined,
          ),
          12.verticalSpace,
          ClaimTextFiledItem(
            title: LocaleKeys.claimLicense.tr(),
            hint: LocaleKeys.claimLicenseHint.tr(),
            icon: Icons.file_present_outlined,
          ),
          12.verticalSpace,
          ClaimTextFiledItem(
            title: LocaleKeys.claimNote.tr(),
            hint: LocaleKeys.claimNoteHint.tr(),
            icon: Icons.note_outlined,
            isNote: true,
          ),
          12.verticalSpace,
        ],
      ),
    );
  }
}

class ClaimTextFiledItem extends StatelessWidget {
  final String title;
  final String hint;
  final IconData icon;
  final bool isNote;
  const ClaimTextFiledItem({
    super.key,
    required this.title,
    required this.hint,
    required this.icon,
    this.isNote = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18.r, color: ColorManager.primary),
            4.horizontalSpace,
            Text(title, style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.primary)),
          ],
        ),
        8.verticalSpace,
        CustomTextField(
          withBorder: false,
          fillColor: ColorManager.blackSwatch[3],
          hint: hint,
          borderRadius: 12.r,
          verticalContentPadding: isNote ? 16.h : 8.h,
          horizontalContentPadding: 16.w,
          maxLines: isNote ? 3 : 1,
        ),
      ],
    );
  }
}
