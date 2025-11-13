import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import '../../../../../../app/resources/assets_manager.dart';
import 'feedback_bottom_sheet.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: List.generate(stars.length, (index) => stars[index])),
              GestureDetector(
                onTap: () => _showFeedBackBttomSheet(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ColorManager.primary, width: 2),
                  ),
                  child: Text(
                    "Feedback",
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(color: ColorManager.primary, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildUserActionContainer(context: context, title: "claim", onTap: () {}),
              4.horizontalSpace,
              _buildUserActionContainer(context: context, title: "Report", onTap: () {}, read: true),
            ],
          ),
        ],
      ).horizontalPadding(padding: 16.w),
    );
  }

  void _showFeedBackBttomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.white,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) {
        return const FeedbackBottomSheet();
      },
    );
  }

  Widget _buildUserActionContainer({
    required BuildContext context,
    required String title,
    bool read = false,
    required Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: read ? ColorManager.red : ColorManager.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_rounded, color: ColorManager.white, size: 15.r),
            4.horizontalSpace,
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.white, fontSize: 12),
            ),
          ],
        ),
      ),
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
