import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';

import '../../../../../../app/resources/assets_manager.dart';
import '../../../../../../app/routes/router.gr.dart';

class HomeAppBarHeaderSection extends StatelessWidget {
  final bool showNotificationIcon;

  const HomeAppBarHeaderSection({super.key, this.showNotificationIcon = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(ImageManager.logo),
            Row(
              children: [
                if (showNotificationIcon)
                  CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: IconButton(
                      icon: SvgPicture.asset(IconManager.notification),
                      onPressed: () {
                        context.router.push(NotificationRoute());
                      },
                    ),
                  ),
                6.horizontalSpace,
                CircleAvatar(
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      IconManager.profile,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    onPressed: () {
                      context.router.push(ProfileRoute());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.h),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (prev, curr) => prev.locationState != curr.locationState || prev.userAddress != curr.userAddress,
          builder: (context, state) {
            String text;

            if (state.userAddress != null && state.userAddress!.isNotEmpty) {
              text = state.userAddress!;
              return Row(
                children: [
                  SvgPicture.asset(IconManager.location),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
