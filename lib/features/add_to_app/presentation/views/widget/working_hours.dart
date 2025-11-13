import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';

class WorkingHours extends StatelessWidget {
  const WorkingHours({super.key});

  @override
  Widget build(BuildContext context) {
    return AddContainer(
      padding: REdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Working Time", style: Theme.of(context).textTheme.headlineMedium),
          12.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: TextFiledItem(title: "Open Time", withTitle: false)),
              8.horizontalSpace,
              Expanded(child: TextFiledItem(title: "Close Time", withTitle: false)),
            ],
          ),
          12.verticalSpace,
          DropDownItem(title: "Work All days", items: [], onChanged: null, withTitle: false),
        ],
      ),
    );
  }
}
