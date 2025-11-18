import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/add_action_button.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

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
                    LocaleKeys.addScreenWelcomeTitle.tr(),
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.white, fontSize: 24),
                  ),
                ),
                24.verticalSpace,
                Center(
                  child: Text(
                    LocaleKeys.addScreenSubtitle.tr(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
                  ),
                ),

                24.verticalSpace,
                ...[
                  AddActionButton(
                    icon: IconManager.addEvent,
                    title: LocaleKeys.addEventActionTitle.tr(),
                    subtitle: LocaleKeys.addEventActionSubtitle.tr(),
                    onTap: () {
                      context.router.navigate(AddEventRoute());
                    },
                    gradient: ColorManager.addEventGradient,
                  ),
                  12.verticalSpace,
                  AddActionButton(
                    icon: IconManager.addClassified,
                    title: LocaleKeys.addClassifiedActionTitle.tr(),
                    subtitle: LocaleKeys.addClassifiedActionSubtitle.tr(),
                    onTap: () {
                      context.router.navigate(AddClassifiedRoute());
                    },
                    gradient: ColorManager.addClassifiedGradient,
                  ),
                  12.verticalSpace,
                  AddActionButton(
                    icon: IconManager.location,
                    isLocation: true,
                    title: LocaleKeys.addMissingPlaceActionTitle.tr(),
                    subtitle: LocaleKeys.addMissingPlaceActionSubtitle.tr(),
                    onTap: () {
                      context.router.navigate(AddMissingPlaceRoute());
                    },
                    gradient: ColorManager.addMissingPlaceGradient,
                  ),
                ],
                40.verticalSpace,
                Center(
                  child: Text(
                    LocaleKeys.addSupportText.tr(),
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
