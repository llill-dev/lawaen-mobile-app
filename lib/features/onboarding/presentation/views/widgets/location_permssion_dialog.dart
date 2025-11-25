import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/location_manager/location_cubit/location_permission_cubit.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class LocationPermissionDialog extends StatelessWidget {
  const LocationPermissionDialog({super.key, this.onClose});

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<LocationPermissionCubit>();
    final router = context.router;

    void goToLogin() {
      onClose?.call();
      router.replace(const LoginRoute());
    }

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: BlocConsumer<LocationPermissionCubit, LocationPermissionState>(
          bloc: cubit,
          listener: (context, state) {
            if (state is LocationPermissionGranted ||
                state is LocationPermissionDenied ||
                state is LocationPermissionForeverDenied ||
                state is LocationPermissionServiceDisabled) {
              goToLogin();
            }
          },
          builder: (context, state) {
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
                  LocaleKeys.locationPermissionDialogMessage.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.black),
                ),
                24.verticalSpace,
                if (state is LocationPermissionLoading)
                  const LoadingWidget()
                else
                  PrimaryButton(
                    onPressed: () {
                      cubit.requestLocation();
                    },
                    text: LocaleKeys.enableLocation.tr(),
                    height: 45.h,
                  ),
                12.verticalSpace,
                GestureDetector(
                  onTap: goToLogin,
                  child: Text(LocaleKeys.denyLocation.tr(), style: Theme.of(context).textTheme.headlineSmall),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
