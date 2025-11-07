// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../resources/assets_manager.dart';

// AppBar customAppBar({
//   required String title,
//   VoidCallback? onPressed,
//   required BuildContext context,
//   List<Widget>? actions,
//   bool centerTitle = false,
//   bool withBackButton = true,
//   double titleSpacing = 0,
//   TextStyle? titleStyle,
// }) {
//   return AppBar(
//     titleSpacing: titleSpacing,
//     centerTitle: centerTitle,
//     title: AutoSizeText(
//       title,
//       style: titleStyle ?? Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20.sp),
//     ),
//     leading: withBackButton
//         ? IconButton(
//             icon: SvgPicture.asset(IconManager.arrowBack, width: 16.w, height: 16.h),
//             onPressed: onPressed ?? () => Navigator.pop(context),
//             padding: EdgeInsets.zero,
//             constraints: BoxConstraints(),
//           )
//         : null,
//     actions: actions,
//     foregroundColor: Colors.transparent,
//     toolbarHeight: kToolbarHeight,
//   );
// }
