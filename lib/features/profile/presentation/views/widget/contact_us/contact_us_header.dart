import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class ContactUsHeader extends StatelessWidget {
  const ContactUsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 4, offset: const Offset(0, 3))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: ColorManager.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: ColorManager.homeAppBarGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SvgPicture.asset(
              IconManager.sendFeedback,
              width: 35,
              height: 35,
              colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
            ),
          ),
          24.verticalSpace,
          Text(LocaleKeys.contactUs.tr(), style: Theme.of(context).textTheme.displayLarge),
          32.verticalSpace,
          Text(LocaleKeys.contactUsFormDescription.tr(), style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}
