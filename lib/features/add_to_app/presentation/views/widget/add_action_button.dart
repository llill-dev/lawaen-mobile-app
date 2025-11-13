import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class AddActionButton extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Function() onTap;
  final List<Color> gradient;
  final bool isLocation;
  const AddActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.gradient,
    this.isLocation = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(color: ColorManager.white, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: gradient),
                borderRadius: BorderRadius.circular(14),
              ),
              child: SvgPicture.asset(icon, width: isLocation ? 24.w : null, height: isLocation ? 24.h : null),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineMedium),
                  8.verticalSpace,
                  Text(subtitle, style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
            ),
            10.horizontalSpace,
            SvgPicture.asset(IconManager.arrowLeft),
          ],
        ),
      ),
    );
  }
}
