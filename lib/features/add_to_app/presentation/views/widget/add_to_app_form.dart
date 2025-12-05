import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class AddToAppForm extends StatelessWidget {
  final bool isEvent;
  final bool isMissingPlace;
  final bool isClassified;
  const AddToAppForm({super.key, this.isEvent = false, this.isMissingPlace = false, this.isClassified = false});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          DropDownItem(title: LocaleKeys.selectMainCategory.tr(), items: [], onChanged: null),
          12.verticalSpace,
          DropDownItem(title: LocaleKeys.selectSubCategory.tr(), items: [], onChanged: null),
          12.verticalSpace,
          TextFiledItem(title: LocaleKeys.fullName.tr()),
          if (isEvent) ...[12.verticalSpace, TextFiledItem(title: LocaleKeys.eventType.tr())],
          12.verticalSpace,
          TextFiledItem(title: LocaleKeys.description.tr(), maxLines: 4),
          12.verticalSpace,
          TextFiledItem(title: LocaleKeys.phoneNumberWithCode.tr()),
          12.verticalSpace,
          TextFiledItem(title: LocaleKeys.whatsappNumber.tr()),
          if (isClassified) ...[12.verticalSpace, TextFiledItem(title: LocaleKeys.price.tr())],

          if (isEvent) ...[
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.facebookPageLink.tr()),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.instagramPageLink.tr()),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.price.tr()),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.bookingFee.tr()),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.organizerPageLink.tr()),
          ],
          if (isMissingPlace) ...[
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.facebookPageLink.tr()),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.instagramPageLink.tr()),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.websiteLink.tr()),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.emailAddress.tr()),
          ],
        ],
      ),
    );
  }
}
