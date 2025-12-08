import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class EmptyEvent extends StatelessWidget {
  const EmptyEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(IconManager.emptyEvent),
        12.verticalSpace,
        Text(LocaleKeys.noUpcomingEvent.tr(), style: Theme.of(context).textTheme.headlineLarge),
        12.verticalSpace,
        Text(
          LocaleKeys.noUpcomingEventDescription.tr(),
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        24.verticalSpace,
        GestureDetector(
          onTap: () => context.router.push(AddEventRoute()),
          child: Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(color: Color(0xffF5F3FF), borderRadius: BorderRadius.circular(12)),
            child: Text(
              LocaleKeys.createEvent.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Color(0xff7F22FE)),
            ),
          ),
        ),
      ],
    );
  }
}
