import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class LinksItemDetials extends StatelessWidget {
  final String info;
  final String? svg;
  final bool isTextOnly;
  final void Function()? onTap;

  const LinksItemDetials({super.key, required this.info, this.svg, this.onTap, this.isTextOnly = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isTextOnly ? ColorManager.primary : ColorManager.white,
          borderRadius: BorderRadius.circular(10),
          border: !isTextOnly ? Border.all(color: ColorManager.primary) : null,
        ),
        child: Row(
          children: [
            if (svg != null && svg!.isNotEmpty) ...[
              SvgPicture.string(
                svg!,
                width: 22,
                height: 22,
                colorFilter: const ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
              ),
              4.horizontalSpace,
            ],

            Text(
              info,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: isTextOnly ? ColorManager.white : ColorManager.primary),
            ),
          ],
        ),
      ),
    );
  }
}
