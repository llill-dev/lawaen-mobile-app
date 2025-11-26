import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_body/settings_itme.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          Row(
            children: [
              GestureDetector(
                onTap: () => context.router.pop(),
                child: const Icon(Icons.arrow_back, size: 18, color: ColorManager.black),
              ),
              const SizedBox(width: 16),
              Text(LocaleKeys.settings.tr(), style: Theme.of(context).textTheme.headlineMedium),
            ],
          ).horizontalPadding(padding: 16.w),

          const SizedBox(height: 16),

          _SettingsContainer(
            child: Column(
              children: [
                SettingsItme(title: LocaleKeys.language.tr(), icon: IconManager.languages, onTap: () {}),
                SettingsItme(
                  title: LocaleKeys.location.tr(),
                  icon: IconManager.location,
                  iconColor: ColorManager.green,
                  iconSize: 22,
                  onTap: () {},
                ),
                SettingsItme(title: LocaleKeys.claim.tr(), icon: IconManager.claimProfile, onTap: () {}),
                SettingsItme(title: LocaleKeys.helpSupport.tr(), icon: IconManager.help, onTap: () {}),
                SettingsItme(title: LocaleKeys.aboutApp.tr(), icon: IconManager.about, onTap: () {}),
                SettingsItme(title: LocaleKeys.termsAndConditions.tr(), icon: IconManager.terms, onTap: () {}),
                SettingsItme(
                  title: LocaleKeys.privacyPolicy.tr(),
                  icon: IconManager.privacy,
                  onTap: () {},
                  hasDivider: false,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _SettingsContainer(
            child: Column(
              children: [
                SettingsItme(
                  title: LocaleKeys.logout.tr(),
                  icon: IconManager.logout,
                  onTap: () {
                    getIt<AppPreferences>().logout();
                    context.router.pushAndPopUntil(LoginRoute(), predicate: (route) => false);
                  },
                ),
                SettingsItme(
                  title: LocaleKeys.deleteAccount.tr(),
                  icon: IconManager.deleteAccount,
                  onTap: () {},
                  hasDivider: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsContainer extends StatelessWidget {
  final Widget child;
  const _SettingsContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: ColorManager.black.withValues(alpha: 0.25), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}
