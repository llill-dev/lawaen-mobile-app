import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';

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
          DropDownItem(title: "Select the main category", items: [], onChanged: null),
          12.verticalSpace,
          DropDownItem(title: "Select the sub category", items: [], onChanged: null),
          12.verticalSpace,
          TextFiledItem(title: "Full Name"),
          if (isEvent) ...[12.verticalSpace, TextFiledItem(title: "Event type")],
          12.verticalSpace,
          TextFiledItem(title: "Description", maxLines: 4),
          12.verticalSpace,
          TextFiledItem(title: "Phone number with city code"),
          12.verticalSpace,
          TextFiledItem(title: "WhatsApp number"),
          if (isClassified) ...[12.verticalSpace, TextFiledItem(title: "Price")],
          if (isEvent) ...[
            12.verticalSpace,
            TextFiledItem(title: "Facebook page link"),
            12.verticalSpace,
            TextFiledItem(title: "Instagram page link"),
            12.verticalSpace,
            TextFiledItem(title: "Price"),
            12.verticalSpace,
            TextFiledItem(title: "Booking Fee"),
            12.verticalSpace,
            TextFiledItem(title: "Organizer's page link"),
          ],
          if (isMissingPlace) ...[
            12.verticalSpace,
            TextFiledItem(title: "Facebook page link"),
            12.verticalSpace,
            TextFiledItem(title: "Instagram page link"),
            12.verticalSpace,
            TextFiledItem(title: "website link"),
            12.verticalSpace,
            TextFiledItem(title: "email"),
          ],
        ],
      ),
    );
  }
}
