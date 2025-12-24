import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/functions/url_launcher.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/core/widgets/show_language_bottom_sheet.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/resources/language_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/features/onboarding/presentation/views/widgets/location_permssion_dialog.dart';
import 'package:lawaen/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_body/profile_pages_section.dart';
import 'package:lawaen/features/profile/presentation/views/widget/profile_body/settings_itme.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({super.key});

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  late final AuthCubit _authCubit;
  late final AppPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _prefs = getIt<AppPreferences>();
  }

  void _navigateToLogin() {
    context.router.pushAndPopUntil(LoginRoute(), predicate: (route) => false);
  }

  Widget _loadingTitle() {
    return const SizedBox(width: 16, height: 16, child: LoadingWidget());
  }

  void _showDeleteConfirmation() {
    alertDialog(
      context: context,
      icon: Icons.warning_rounded,
      iconcolor: ColorManager.red,
      message: LocaleKeys.deleteAccountConfirmation.tr(),
      approveButtonColor: ColorManager.red,
      rejectButtonTitle: LocaleKeys.cancel.tr(),
      approveButtonTitle: LocaleKeys.ok.tr(),
      onConfirm: () {
        _authCubit.deleteAccount();
      },
      onCancel: () {
        context.router.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = _authCubit;
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
                if (_prefs.isGuest)
                  SettingsItme(
                    title: LocaleKeys.signIn.tr(),
                    isLogin: true,
                    icon: "",
                    onTap: () => context.router.push(LoginRoute()),
                  ),
                SettingsItme(
                  title: LocaleKeys.language.tr(),
                  icon: IconManager.languages,
                  onTap: () {
                    final appPreferences = getIt<AppPreferences>();
                    showLanguageBottomSheet(
                      title: LocaleKeys.language.tr(),
                      context: context,
                      options: [LocaleKeys.english.tr(), LocaleKeys.arabic.tr()],
                      selectedOption: appPreferences.getAppLanguage() == english
                          ? LocaleKeys.english.tr()
                          : LocaleKeys.arabic.tr(),
                      onSelect: (p0) async {
                        appPreferences.changeAppLanguage();
                        context.setLocale(appPreferences.getAppLanguage() == english ? englishLocale : arabicLocale);
                        setLocaleIdentifier(appPreferences.getAppLanguage() == english ? 'en_US' : 'ar_SA');
                        context.router.pushAndPopUntil(NavigationControllerRoute(), predicate: (route) => false);
                        context.read<HomeCubit>().initHome();
                        context.read<ProfileCubit>().retryProfilePages();
                      },
                    );
                  },
                ),

                SettingsItme(
                  title: LocaleKeys.location.tr(),
                  icon: IconManager.location,
                  iconColor: ColorManager.green,
                  iconSize: 22,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (dialogContext) {
                        return LocationPermissionDialog(
                          onApprove: () {
                            context.read<HomeCubit>().initHome();
                          },
                          onClose: () => context.router.pop(),
                        );
                      },
                    );
                  },
                ),

                // SettingsItme(title: LocaleKeys.claim.tr(), icon: IconManager.claimProfile, onTap: () {
                //   context.router.push(ClaimRoute(itemId: itemId, secondCategoryId: secondCategoryId))
                // }),
                SettingsItme(
                  title: "Business center",
                  icon: "",
                  iconData: Icon(Icons.business_center_outlined, color: ColorManager.primary),
                  iconSize: 22,
                  onTap: () {
                    if (_prefs.isGuest) {
                      alertDialog(
                        context: context,
                        message: LocaleKeys.signInToContinue.tr(),
                        onConfirm: () => context.router.push(LoginRoute()),
                        onCancel: () => (),
                        approveButtonTitle: LocaleKeys.signIn.tr(),
                        rejectButtonTitle: LocaleKeys.cancel.tr(),
                      );
                      return;
                    }
                    launchURL(link: "https://cp.lawaen.com/");
                  },
                ),

                SettingsItme(
                  title: LocaleKeys.addMissingPlaceTitle.tr(),
                  icon: "",
                  iconData: Icon(Icons.place_outlined, color: ColorManager.primary),
                  iconSize: 22,
                  onTap: () {
                    if (_prefs.isGuest) {
                      alertDialog(
                        context: context,
                        message: LocaleKeys.signInToContinue.tr(),
                        onConfirm: () => context.router.push(LoginRoute()),
                        onCancel: () => (),
                        approveButtonTitle: LocaleKeys.signIn.tr(),
                        rejectButtonTitle: LocaleKeys.cancel.tr(),
                      );
                      return;
                    }
                    context.router.push(AddMissingPlaceRoute());
                  },
                ),

                ProfilePagesSection(),
              ],
            ),
          ),

          const SizedBox(height: 16),
          if (!_prefs.isGuest)
            _SettingsContainer(
              child: Column(
                children: [
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: authCubit,
                    listenWhen: (previous, current) {
                      if (current is AuthFailure) return previous is AuthLogoutLoading;
                      return current is AuthLogoutSuccess;
                    },
                    listener: (context, state) async {
                      if (state is AuthLogoutSuccess || state is AuthFailure) {
                        await _prefs.logout();
                        await _prefs.setGuest(true);
                        if (!mounted) return;
                        _navigateToLogin();
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is AuthLogoutLoading;
                      return SettingsItme(
                        title: LocaleKeys.logout.tr(),
                        titleWidget: isLoading ? _loadingTitle() : null,
                        icon: IconManager.logout,
                        onTap: isLoading ? null : () => authCubit.logout(),
                      );
                    },
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: authCubit,
                    listenWhen: (previous, current) {
                      if (current is AuthFailure) return previous is AuthDeleteAccountLoading;
                      return current is AuthDeleteAccountSuccess;
                    },
                    listener: (context, state) async {
                      if (state is AuthDeleteAccountSuccess) {
                        await _prefs.logout();
                        await _prefs.setGuest(true);
                        if (!mounted) return;
                        _navigateToLogin();
                      } else if (state is AuthFailure) {
                        if (!mounted) return;
                        showToast(message: state.errorMessage, isError: true);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is AuthDeleteAccountLoading;
                      return SettingsItme(
                        title: LocaleKeys.deleteAccount.tr(),
                        titleWidget: isLoading ? _loadingTitle() : null,
                        icon: IconManager.deleteAccount,
                        onTap: isLoading ? null : _showDeleteConfirmation,
                        hasDivider: false,
                      );
                    },
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
