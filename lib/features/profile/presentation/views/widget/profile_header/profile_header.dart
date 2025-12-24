import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_container.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_header/profile_sections_grid.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_header/profile_user_info.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isGuest = getIt<AppPreferences>().isGuest;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 280.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              top: 0,
              bottom: 120.h,
              child: HomeAppBarContainer(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h, bottom: 75.h),
                child: isGuest ? SizedBox.shrink() : const ProfileUserInfo(),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ProfileSectionsGrid().horizontalPadding(padding: 16.w),
                  //Positioned(left: 50.w, right: 50.w, top: 40.h, child: SvgPicture.asset(IconManager.qrCodeProfile)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
