import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/generated/locale_keys.g.dart';
import 'package:otp_text_field_v2/otp_text_field_v2.dart';

class OtpVerificationForm extends StatefulWidget {
  final String contact;
  const OtpVerificationForm({super.key, required this.contact});

  @override
  State<OtpVerificationForm> createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  final _otpController = OtpFieldControllerV2();
  String _otpCode = '';

  @override
  void dispose() {
    _otpController.clear();
    super.dispose();
  }

  void _submit() {
    if (_otpCode.length != 5) {
      showToast(message: LocaleKeys.fieldRequired.tr(), isError: true);
      return;
    }
    if (!RegExp(r'^\d{5}$').hasMatch(_otpCode)) {
      showToast(message: LocaleKeys.invalidInput.tr(), isError: true);
      return;
    }
    context.router.push(ResetPasswordRoute(contact: widget.contact));
  }

  @override
  Widget build(BuildContext context) {
    final availableWidth = MediaQuery.sizeOf(context).width - 40.w;
    return Column(
      children: [
        OTPTextFieldV2(
          controller: _otpController,
          length: 5,
          width: availableWidth,
          fieldWidth: 52.w,
          spaceBetween: 12.w,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          textFieldAlignment: MainAxisAlignment.spaceBetween,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headlineMedium ?? const TextStyle(),
          outlineBorderRadius: 12.r,
          fieldStyle: FieldStyle.box,
          otpFieldStyle: OtpFieldStyle(
            backgroundColor: ColorManager.blackSwatch[3]!,
            borderColor: ColorManager.blackSwatch[4]!,
            enabledBorderColor: ColorManager.blackSwatch[4]!,
            focusBorderColor: ColorManager.black,
            disabledBorderColor: ColorManager.blackSwatch[4]!,
            errorBorderColor: ColorManager.red,
          ),
          onChanged: (value) => _otpCode = value,
          onCompleted: (value) => _otpCode = value,
          cursorColor: ColorManager.primary,
        ),
        32.verticalSpace,
        PrimaryButton(
          text: LocaleKeys.next.tr(),
          onPressed: _submit,
          height: 40.h,
        ),
      ],
    );
  }
}
