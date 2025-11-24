import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class ProfileSectionsGrid extends StatelessWidget {
  const ProfileSectionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      _ProfileSectionData(
        title: LocaleKeys.savedPlace.tr(),
        subtitle: "12 Items",
        icon: IconManager.saved,
        onTap: () => context.pushRoute(FavoritesRoute()),
      ),
      _ProfileSectionData(
        title: LocaleKeys.reatings.tr(),
        subtitle: "4 Items",
        icon: IconManager.retings,
        onTap: () => context.pushRoute(RatingsRoute()),
      ),
      _ProfileSectionData(
        title: LocaleKeys.contactUs.tr(),
        subtitle: "8 Items",
        icon: IconManager.contactUs,
        onTap: () => context.pushRoute(ContactUsRoute()),
      ),
      _ProfileSectionData(
        title: LocaleKeys.notifications.tr(),
        subtitle: "3 Items",
        icon: IconManager.notification,
        notification: true,
        onTap: () => context.pushRoute(NotificationRoute()),
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = 12.w;
        final rowSpacing = 12.h;
        final itemWidth = (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: rowSpacing,
          children: [
            for (final s in sections)
              SizedBox(
                width: itemWidth,
                child: _ProfileSectionItem(section: s),
              ),
          ],
        );
      },
    );
  }
}

class _ProfileSectionItem extends StatelessWidget {
  final _ProfileSectionData section;
  const _ProfileSectionItem({required this.section});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: section.onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(color: ColorManager.black.withValues(alpha: 0.12), blurRadius: 6, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: ColorManager.lightGrey,
              child: SvgPicture.asset(
                section.icon,
                colorFilter: section.notification ? ColorFilter.mode(Color(0xffAD46FF), BlendMode.srcIn) : null,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.black),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    section.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall,
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

class _ProfileSectionData {
  final String title;
  final String subtitle;
  final String icon;
  final bool notification;
  final VoidCallback onTap;
  _ProfileSectionData({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.notification = false,
    required this.onTap,
  });
}
