import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/location_manager/location_cubit/location_permission_cubit.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class LocationPermissionDialog extends StatelessWidget {
  const LocationPermissionDialog({super.key, this.onClose, this.onApprove, this.isRefreshFlow = false});

  final VoidCallback? onClose;
  final VoidCallback? onApprove;

  /// false = onboarding (Enable / Deny)
  /// true  = refresh (Enable / Cancel)
  final bool isRefreshFlow;

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<LocationPermissionCubit>();
    final router = context.router;

    void popDialog() {
      onClose?.call();
      Navigator.of(context).pop();
    }

    void goToHome() {
      onClose?.call();
      router.replace(NavigationControllerRoute());
    }

    String messageForState(LocationPermissionState state) {
      // You can change these keys/messages as you like.
      if (state is LocationPermissionNeedsServiceEnabled) {
        return LocaleKeys.locationServicesDisabledMessage.tr();
      }
      if (state is LocationPermissionNeedsAppSettings) {
        return LocaleKeys.locationPermissionForeverDeniedMessage.tr();
      }
      if (state is LocationPermissionNeedsPermission) {
        return LocaleKeys.locationPermissionDeniedMessage.tr();
      }
      if (state is LocationPermissionError) {
        return state.message;
      }
      return LocaleKeys.locationPermissionDialogMessage.tr();
    }

    @override
    void _request({required bool forceRequest}) {
      // ignore: discarded_futures
      cubit.requestLocation(forceRequest: forceRequest);
    }

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: BlocConsumer<LocationPermissionCubit, LocationPermissionState>(
          bloc: cubit,
          listenWhen: (_, __) => true,
          listener: (context, state) {
            // Success: close dialog and trigger update
            if (state is LocationPermissionGranted) {
              onApprove?.call();
              if (isRefreshFlow) {
                popDialog();
              } else {
                goToHome();
              }
              return;
            }

            // Onboarding: allow continuing even if user refuses / can't enable now
            if (!isRefreshFlow &&
                (state is LocationPermissionNeedsPermission ||
                    state is LocationPermissionNeedsAppSettings ||
                    state is LocationPermissionNeedsServiceEnabled)) {
              goToHome();
            }
          },
          builder: (context, state) {
            final isLoading = state is LocationPermissionLoading;

            final showOpenLocationSettings = isRefreshFlow && state is LocationPermissionNeedsServiceEnabled;
            final showOpenAppSettings = isRefreshFlow && state is LocationPermissionNeedsAppSettings;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                8.verticalSpace,
                Text(
                  LocaleKeys.locationPermissionDialogTitle.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                20.verticalSpace,
                Text(
                  messageForState(state),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.black),
                ),
                24.verticalSpace,

                if (isLoading)
                  const LoadingWidget()
                else ...[
                  // Main action:
                  // - onboarding: requests permission (user pressed enable)
                  // - refresh: requests permission (user pressed enable)
                  PrimaryButton(
                    onPressed: () async {
                      await cubit.requestLocation(forceRequest: true);
                    },
                    text: LocaleKeys.enableLocation.tr(),
                    height: 45.h,
                  ),

                  // If the problem is "Location services OFF" (Android),
                  // show an explicit button to open Location settings.
                  if (showOpenLocationSettings) ...[
                    12.verticalSpace,
                    PrimaryButton(
                      onPressed: () async {
                        await cubit.openLocationSettings();
                        // user will return; recheck on resume in your screen (recommended)
                        // also allow manual recheck here:
                        await cubit.recheckAfterSettings();
                      },
                      text: LocaleKeys.openLocationSettings.tr(),
                      height: 45.h,
                    ),
                  ],

                  // If permission is "denied forever", show app settings button.
                  if (showOpenAppSettings) ...[
                    12.verticalSpace,
                    PrimaryButton(
                      onPressed: () async {
                        await cubit.openAppSettings();
                        await cubit.recheckAfterSettings();
                      },
                      text: LocaleKeys.openSettings.tr(),
                      height: 45.h,
                    ),
                  ],
                ],

                12.verticalSpace,

                // Bottom action:
                // - refresh: Cancel (just pop)
                // - onboarding: Deny (continue to home)
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () {
                          if (isRefreshFlow) {
                            popDialog();
                          } else {
                            goToHome();
                          }
                        },
                  child: Text(
                    isRefreshFlow ? LocaleKeys.cancel.tr() : LocaleKeys.denyLocation.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
