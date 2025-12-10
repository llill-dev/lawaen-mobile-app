import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = getIt<AppPreferences>();
    final user = prefs.getUserInfo();

    final String name = user?.name ?? "";
    final String emailOrPhone = user?.emailOrPhone ?? "";
    final String? imageUrl = user?.image;

    final bool hasImage = imageUrl != null && imageUrl.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50.w,
          height: 50.w,
          child: hasImage
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedImage(url: imageUrl, width: 50.w, height: 50.w, radius: BorderRadius.circular(40)),
                )
              : Image.asset(ImageManager.profile, color: ColorManager.white, width: 50.w, height: 50.w),
        ),

        SizedBox(width: 16.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 4.h),

              Text(
                emailOrPhone,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        SizedBox(width: 12.w),

        CircleAvatar(
          radius: 20.r,
          backgroundColor: ColorManager.white.withValues(alpha: 0.2),
          child: const Icon(Icons.edit, color: ColorManager.white),
        ),
      ],
    );
  }
}
