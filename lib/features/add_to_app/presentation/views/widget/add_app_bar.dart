import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class AddAppBar extends StatelessWidget {
  final String title;
  const AddAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.primary,
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: ColorManager.homeAppBarGradient,
        // ),
        boxShadow: [
          BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 10.r, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          const PrimaryBackButton(
            withShadow: false,
            iconColor: ColorManager.white,
            backgroundColor: Colors.transparent,
            fontSize: 16,
            iconSize: 18,
          ),
          12.verticalSpace,
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.white, fontSize: 24),
            ),
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
