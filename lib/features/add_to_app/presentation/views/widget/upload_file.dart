import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import 'add_container.dart';

class UploadFile extends StatelessWidget {
  const UploadFile({super.key});
  @override
  Widget build(BuildContext context) {
    return AddContainer(
      child: Column(
        children: [
          SvgPicture.asset(IconManager.upload),
          12.verticalSpace,
          Text(
            "Upload your image",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: ColorManager.green),
          ),
          12.verticalSpace,
          Text(
            "Image size must not exceed 10.6 Kb",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.red),
          ),
        ],
      ),
    );
  }
}
