import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';
import 'package:otp_text_field_v2/otp_text_field_v2.dart';

class OtpVerificationForm extends StatefulWidget {
  final String contact;
  const OtpVerificationForm({super.key, required this.contact});

  @override
  State<OtpVerificationForm> createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  String _otpCode = '';

  void _submit() {
    if (_otpCode.length != 5) {
      showToast(message: LocaleKeys.fieldRequired.tr(), isError: true);
      return;
    }
    context.read<ForgetPasswordCubit>().sendOtpVerification(widget.contact, _otpCode);
  }

  @override
  Widget build(BuildContext context) {
    final availableWidth = MediaQuery.sizeOf(context).width - 40.w;
    return Column(
      children: [
        OTPTextFieldV2(
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
          cursorColor: ColorManager.primary,
        ),
        32.verticalSpace,
        BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state.verifyState == RequestState.error) {
              final message = state.verifyError ?? LocaleKeys.defaultError.tr();
              showToast(message: message, isError: true);
            }
            if (state.verifyState == RequestState.success) {
              context.router.push(ResetPasswordRoute(contact: widget.contact));
              context.read<ForgetPasswordCubit>().resetStates();
            }
          },
          builder: (context, state) {
            return PrimaryButton(
              text: LocaleKeys.next.tr(),
              isLoading: state.verifyState == RequestState.loading,
              onPressed: state.verifyState == RequestState.loading ? null : _submit,
              height: 40.h,
            );
          },
        ),
      ],
    );
  }
}
