import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

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
            Image.asset(ImageManager.logo, width: 50.w, height: 50.h),
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
                      if (getIt<AppPreferences>().isGuest) {
                        alertDialog(
                          context: context,
                          message: LocaleKeys.signInToContinue.tr(),
                          onConfirm: () => context.router.push(LoginRoute()),
                          onCancel: () => (),
                          approveButtonTitle: LocaleKeys.signIn.tr(),
                          rejectButtonTitle: LocaleKeys.cancel.tr(),
                        );
                      } else {
                        context.router.push(ProfileRoute());
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.h),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (prev, curr) => prev.currentCity != curr.currentCity,
          builder: (context, state) {
            String text;

            if (state.currentCity != null && state.currentCity!.name.isNotEmpty) {
              text = state.currentCity!.name;
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
