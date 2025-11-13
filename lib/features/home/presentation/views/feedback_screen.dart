import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import 'widgets/feedback/feedback_item.dart';

@RoutePage()
class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w, vertical: 10.h),
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    PrimaryBackButton(iconOnlay: true, iconSize: 20),
                    Text(
                      "FeedBack",
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge?.copyWith(color: ColorManager.primary, fontSize: 20),
                    ),
                  ],
                ),
              ),
              buildSpace(height: 24.h),
              SliverList.separated(
                separatorBuilder: (context, index) => 24.verticalSpace,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return FeedBackItem();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
