import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/routes/router.gr.dart';

import '../../../../../app/resources/color_manager.dart';
import '../../../../../generated/locale_keys.g.dart';

class AddYourBusiness extends StatefulWidget {
  const AddYourBusiness({super.key});

  @override
  State<AddYourBusiness> createState() => _AddYourBusinessState();
}

class _AddYourBusinessState extends State<AddYourBusiness> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          if (getIt<AppPreferences>().isGuest) {
            alertDialog(
              context: context,
              message: LocaleKeys.signInToContinue.tr(),
              onConfirm: () => context.router.push(LoginRoute()),
              onCancel: () {},
              approveButtonTitle: LocaleKeys.signIn.tr(),
              rejectButtonTitle: LocaleKeys.cancel.tr(),
            );
          } else {
            context.pushRoute(AddMissingPlaceRoute());
          }
        },
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: ColorManager.white,
              border: Border.all(color: ColorManager.green, width: 2.w),
            ),
            child: Text(
              LocaleKeys.addYourBusiness.tr(),
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
          ).horizontalPadding(padding: 40.w),
        ),
      ),
    );
  }
}
