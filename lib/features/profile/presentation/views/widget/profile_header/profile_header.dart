import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_container.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_header/profile_sections_grid.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_header/profile_user_info.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              HomeAppBarContainer(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h, bottom: 70.h),
                child: ProfileUserInfo(),
              ),
              Positioned(
                bottom: -120.h,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    ProfileSectionsGrid().horizontalPadding(padding: 16.w),
                    Positioned(left: 50.w, right: 50.w, top: 40.h, child: SvgPicture.asset(IconManager.qrCodeProfile)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 130.h),
        ],
      ),
    );
  }
}
