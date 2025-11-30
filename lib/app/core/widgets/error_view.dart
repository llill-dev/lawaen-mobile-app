import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import '../../../generated/locale_keys.g.dart';
import 'primary_button.dart';

class ErrorView extends StatelessWidget {
  final String? errorMsg;
  final String? buttonTitle;
  final VoidCallback? onRetry;
  final bool withBackButton;
  const ErrorView({
    super.key,
    this.buttonTitle = LocaleKeys.retry,
    this.errorMsg,
    this.onRetry,
    this.withBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (withBackButton)
          Positioned(
            top: 70.h,
            left: 20.w,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: ColorManager.black, size: 24),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_outlined, color: ColorManager.red, size: 46.r),
            20.verticalSpace,
            Text(errorMsg ?? LocaleKeys.defaultError.tr(), style: Theme.of(context).textTheme.bodyMedium, maxLines: 3),
            if (onRetry != null) ...[
              20.verticalSpace,
              Center(
                child: PrimaryButton(
                  backgroundColor: ColorManager.red,
                  text: buttonTitle?.tr(),
                  onPressed: onRetry,
                  borederColor: ColorManager.red,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
