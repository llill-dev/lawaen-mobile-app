import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_action_button.dart';

@RoutePage()
class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorManager.homeAppBarGradient,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PrimaryBackButton(
                  withShadow: false,
                  iconColor: ColorManager.white,
                  backgroundColor: Colors.transparent,
                ),
                24.verticalSpace,
                Center(
                  child: Text(
                    "Welcome to Your Lawean",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.white, fontSize: 24),
                  ),
                ),
                24.verticalSpace,
                Center(
                  child: Text(
                    "Choose an action to get started",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
                  ),
                ),

                24.verticalSpace,
                ...[
                  AddActionButton(
                    icon: IconManager.addEvent,
                    title: "Add a new event",
                    subtitle: "Create and publish your event",
                    onTap: () {
                      context.router.navigate(AddEventRoute());
                    },
                    gradient: ColorManager.addEventGradient,
                  ),
                  12.verticalSpace,
                  AddActionButton(
                    icon: IconManager.addClassified,
                    title: "Add a new classified",
                    subtitle: "Post a classified advertisement",
                    onTap: () {
                      context.router.navigate(AddClassifiedRoute());
                    },
                    gradient: ColorManager.addClassifiedGradient,
                  ),
                  12.verticalSpace,
                  AddActionButton(
                    icon: IconManager.location,
                    isLocation: true,
                    title: "Add a missing place",
                    subtitle: "Help us add a place to the map",
                    onTap: () {
                      context.router.navigate(AddMissingPlaceRoute());
                    },
                    gradient: ColorManager.addMissingPlaceGradient,
                  ),
                ],
                40.verticalSpace,
                Center(
                  child: Text(
                    "Need help? Contact our support team",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
