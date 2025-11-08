import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/resources/assets_manager.dart';
import '../../../../app/resources/color_manager.dart';

@RoutePage()
class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.arrow_back, color: ColorManager.darkGrey),
                  ),
                  SvgPicture.asset(IconManager.trach),
                ],
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: ColorManager.white,
                  border: Border.all(color: ColorManager.notificationBorderColor, width: 1.9),
                ),
                padding: EdgeInsets.all(12.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: ColorManager.primarySwatch[100],
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                          child: Center(child: SvgPicture.asset(IconManager.discount)),
                        ),
                        SizedBox(width: 15),
                        Column(
                          children: [
                            Text("Special Discount Available!", style: Theme.of(context).textTheme.headlineMedium),
                            6.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("offer", style: Theme.of(context).textTheme.headlineSmall),
                                8.horizontalSpace,
                                Text("Shopping •", style: Theme.of(context).textTheme.headlineSmall),
                                8.horizontalSpace,
                                SvgPicture.asset(IconManager.clock),
                                4.horizontalSpace,
                                Text("2 hours ago", style: Theme.of(context).textTheme.headlineSmall),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Get 30% off on all shopping categories this weekend Get on all shopping categories this weekend Get 30% off on all shopping categories this weekend Get  off on all shopping categories this weekend Get off on all shopping categories this weekend Get off on all shopping categories this weekend Get 30% off on all shopping categories this weekend",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.darkGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
