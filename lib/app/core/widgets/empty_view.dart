import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../resources/assets_manager.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final String? subMessage;
  final String? icon;

  const EmptyView({super.key, required this.message, this.icon, this.subMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon == null)
          SizedBox(width: 170.w, height: 170.w, child: Lottie.asset(JsonManager.dataNotFound))
        else ...[
          SvgPicture.asset(icon!),
          12.verticalSpace,
        ],

        Text(message, style: Theme.of(context).textTheme.headlineLarge),

        if (subMessage != null) Text(subMessage!, style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
