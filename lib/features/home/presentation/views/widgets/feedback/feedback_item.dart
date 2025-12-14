import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';

class FeedBackItem extends StatelessWidget {
  const FeedBackItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () => context.pushRoute(FeedbackChatRoute()),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.primary, width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(IconManager.profileFeddback),
            15.horizontalSpace,
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Robert Fox", style: Theme.of(context).textTheme.displayMedium),
                      Text("15.43", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12)),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hey, let’s play basketball ", style: Theme.of(context).textTheme.headlineSmall),
                      SvgPicture.asset(IconManager.sendFeedback),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
