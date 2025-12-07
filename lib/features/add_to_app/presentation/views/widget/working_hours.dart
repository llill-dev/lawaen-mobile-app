// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lawaen/features/add_to_app/presentation/views/widget/add_container.dart';
// import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
// import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
// import 'package:lawaen/generated/locale_keys.g.dart';

// class WorkingHours extends StatelessWidget {
//   const WorkingHours({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AddContainer(
//       padding: REdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(LocaleKeys.workingTime.tr(), style: Theme.of(context).textTheme.headlineMedium),
//           12.verticalSpace,
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(child: TextFiledItem(title: LocaleKeys.openTime.tr(), withTitle: false)),
//               8.horizontalSpace,
//               Expanded(child: TextFiledItem(title: LocaleKeys.closeTime.tr(), withTitle: false)),
//             ],
//           ),
//           12.verticalSpace,
//           DropDownItem(title: LocaleKeys.workAllDays.tr(), items: [], onChanged: null, withTitle: false),
//         ],
//       ),
//     );
//   }
// }
