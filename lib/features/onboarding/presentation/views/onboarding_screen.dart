import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:lawaen/features/onboarding/presentation/views/widgets/location_permssion_dialog.dart';
import 'package:lawaen/features/onboarding/presentation/views/widgets/onboarding_admin_message_dialog.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _locationDialogFinished = false;
  bool _adminDialogShown = false;
  late final OnboardingCubit cubit;

  @override
  void initState() {
    cubit = context.read<OnboardingCubit>();
    cubit.getAdminMessage();
    super.initState();
  }

  void _maybeShowAdminDialog(BuildContext context, OnboardingState state) {
    if (!_locationDialogFinished) return;
    if (_adminDialogShown) return;

    if (state.messageState != RequestState.success) return;

    final msg = state.message;
    if (msg == null) return;

    final hasText = (msg.message ?? '').trim().isNotEmpty;
    final hasImage = (msg.image ?? '').trim().isNotEmpty;
    final hasBtn = (msg.btn ?? '').trim().isNotEmpty;

    if (!hasText && !hasImage && !hasBtn) return;

    _adminDialogShown = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showDialog(
        context: context,
        useRootNavigator: true,
        builder: (_) => OnboardingAdminMessageDialog(message: msg),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.messageState != current.messageState || previous.message != current.message,
      listener: (context, state) => _maybeShowAdminDialog(context, state),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: ColorManager.onBoardingGradient,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.onBoardingTitle.tr(),
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.white, fontSize: 24),
                  ),
                  24.verticalSpace,
                  Image.asset(ImageManager.onboarding),
                  12.verticalSpace,
                  Text(
                    LocaleKeys.onBoardingMessage.tr(),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: ColorManager.white),
                  ),
                  24.verticalSpace,
                  PrimaryButton(
                    text: LocaleKeys.next.tr(),
                    onPressed: () => _showLocationPermissionDialog(context),
                    textColor: ColorManager.black,
                    backgroundColor: ColorManager.white,
                    borederColor: ColorManager.white,
                    withShadow: true,
                    shadowColor: ColorManager.onBoardingShadowColor,
                    height: 45.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLocationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (dialogContext) {
        return LocationPermissionDialog(
          onClose: () {
            Navigator.of(dialogContext, rootNavigator: true).pop();

            setState(() {
              _locationDialogFinished = true;
            });

            _maybeShowAdminDialog(context, context.read<OnboardingCubit>().state);
          },
        );
      },
    );
  }
}
