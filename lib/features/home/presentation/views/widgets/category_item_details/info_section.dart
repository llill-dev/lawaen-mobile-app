import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';

import '../../../../../../app/resources/color_manager.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(24.w),
          decoration: _buildBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About", style: Theme.of(context).textTheme.headlineLarge),
              10.verticalSpace,
              Text(
                "Life beckons at Banyan Tree, your sanctuary for the senses. Nestled in the heart of Bluewaters Island, our resort offers unparalleled views of the Arabian Gulf. Experience world-class hospitality with state-of-the-art facilities and exceptional service.",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),

        20.verticalSpace,

        Container(
          padding: EdgeInsets.all(24.w),
          decoration: _buildBoxDecoration(),
          child: Column(
            children: [
              InfoItem(),
              12.verticalSpace,
              InfoItem(),
              12.verticalSpace,
              InfoItem(),
              12.verticalSpace,
              InfoItem(),
            ],
          ),
        ),
      ],
    ).horizontalPadding(padding: 16.w);
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: ColorManager.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ColorManager.primary),
      boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 4, offset: Offset(0, 4))],
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => context.router.push(MuneRoute()),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(color: ColorManager.primarySwatch[100], borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(IconManager.location, color: ColorManager.primary, width: 20.w, height: 20.h),
          ),
        ),
        15.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Opening Hours", style: Theme.of(context).textTheme.headlineMedium),
              4.verticalSpace,
              Text("09:00 AM - 06:00 PM", style: Theme.of(context).textTheme.headlineMedium),
              4.verticalSpace,
              Text("Monday - Sunday", style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ],
    );
  }
}
