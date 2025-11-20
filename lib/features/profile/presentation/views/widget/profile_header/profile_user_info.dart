import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(ImageManager.profile, color: ColorManager.white),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ayham Kefo', style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.white)),
              SizedBox(height: 4.h),
              Text(
                'ayham.kefo@gmail.com',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        CircleAvatar(
          radius: 20.r,
          backgroundColor: ColorManager.white.withValues(alpha: 0.2),
          child: Icon(Icons.edit, color: ColorManager.white),
        ),
      ],
    );
  }
}
