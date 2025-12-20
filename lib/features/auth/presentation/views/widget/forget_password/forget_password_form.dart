import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/utils/form_state_mixin.dart';
import 'package:lawaen/app/core/utils/form_utils.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:lawaen/features/auth/presentation/views/widget/auth_text_field_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> with FormStateMixin {
  @override
  int numberOfFields() {
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final forgetCubit = context.read<ForgetPasswordCubit>();
    return Form(
      key: form.key,
      child: Column(
        children: [
          12.verticalSpace,
          AuthTextFieldItem(
            controller: form.controllers[0],
            title: LocaleKeys.phoneNumberOrEmail.tr(),
            hint: LocaleKeys.enterEmailOrPhoneNumber.tr(),
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: LocaleKeys.fieldRequired.tr()),
            ]),
          ),
          32.verticalSpace,
          BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state.forgotState == RequestState.error) {
                final message = state.forgotError ?? LocaleKeys.defaultError.tr();
                showToast(message: message, isError: true);
              }
              if (state.forgotState == RequestState.success) {
                final contact = form.controllers[0].text.trim();
                context.router.push(OtpVerificationRoute(contact: contact));
                forgetCubit.resetStates();
              }
            },
            builder: (context, state) {
              return PrimaryButton(
                text: LocaleKeys.next.tr(),
                isLoading: state.forgotState == RequestState.loading,
                onPressed: state.forgotState == RequestState.loading
                    ? null
                    : () {
                        if (form.key.currentState!.validate()) {
                          final contact = form.controllers[0].text.trim();
                          forgetCubit.sendForgetRequest(contact);
                        }
                      },
                height: 40.h,
              );
            },
          ),
        ],
      ),
    );
  }
}
