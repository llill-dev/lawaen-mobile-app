import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';

class ContactUsForm extends StatelessWidget {
  const ContactUsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        children: [
          DropDownItem(title: "Message Type", items: [], hit: "Choose from here", onChanged: (v) {}),
          16.verticalSpace,
          TextFiledItem(title: "Write your message here", hintText: "Your message here", maxLines: 4),
          16.verticalSpace,
          PrimaryButton(text: "Send Message", onPressed: () {}),
        ],
      ),
    );
  }
}
