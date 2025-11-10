import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import '../../../../../../app/resources/assets_manager.dart';

class BasicInfoSection extends StatelessWidget {
  const BasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stars = [
      Icon(Icons.star_rounded, size: 32.r, color: ColorManager.darkGrey),
      Icon(Icons.star_rounded, size: 32.r, color: ColorManager.darkGrey),
      Icon(Icons.star_rounded, size: 32.r, color: ColorManager.darkGrey),
      Icon(Icons.star_rounded, size: 32.r, color: ColorManager.darkGrey),
      Icon(Icons.star_rounded, size: 32.r, color: ColorManager.darkGrey),
    ];

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(IconManager.location, color: ColorManager.black),
              4.horizontalSpace,
              Text("Damasucs", style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
          12.verticalSpace,
          SizedBox(
            height: 0.12.sh * 0.4,
            child: ListView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              children: [
                LinksItemDetials(info: "Go to the site"),
                10.horizontalSpace,
                LinksItemDetials(info: "phone", icon: Icons.phone_outlined),
                10.horizontalSpace,
                LinksItemDetials(info: "facebook", icon: Icons.facebook_outlined),
                10.horizontalSpace,
                LinksItemDetials(info: "facebook", icon: Icons.facebook_outlined),
              ],
            ),
          ),
          12.verticalSpace,
          Text(
            "Life beckons at Banyan Tree, your sanctuary for the senses.",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          12.verticalSpace,
          Row(
            children: [
              Row(children: List.generate(stars.length, (index) => stars[index])),
              8.horizontalSpace,
              Text(
                "0 rating Count",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.orange),
              ),
            ],
          ),
        ],
      ).horizontalPadding(padding: 16.w),
    );
  }
}

class LinksItemDetials extends StatelessWidget {
  final String info;
  final IconData? icon;
  const LinksItemDetials({super.key, required this.info, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: icon != null ? ColorManager.white : ColorManager.primary,
        borderRadius: BorderRadius.circular(10),
        border: icon != null ? Border.all(color: ColorManager.primary) : null,
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: ColorManager.primary),
          4.horizontalSpace,
          Text(
            info,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: icon == null ? ColorManager.white : ColorManager.primary),
          ),
        ],
      ),
    );
  }
}
