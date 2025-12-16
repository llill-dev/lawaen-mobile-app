import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class OffersCircularActionButton extends StatelessWidget {
  final String icon;
  final void Function()? onTap;
  const OffersCircularActionButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: ColorManager.green, shape: BoxShape.circle),
        padding: EdgeInsets.all(16.w),
        child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(ColorManager.black, BlendMode.srcIn)),
      ),
    );
  }
}
