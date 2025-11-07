import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/locale_keys.g.dart';
import 'primary_button.dart';

class ErrorView extends StatelessWidget {
  final String? errorMsg;
  final String? buttonTitle;
  final VoidCallback? onRetry;

  const ErrorView({super.key, this.buttonTitle = LocaleKeys.retry, this.errorMsg, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 300.w,
          child: Text(
            errorMsg ?? LocaleKeys.defaultError.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 3,
          ),
        ),
        if (onRetry != null) ...[SizedBox(height: 20.h), PrimaryButton(text: buttonTitle?.tr(), onPressed: onRetry)],
      ],
    );
  }
}
