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

class ResetPasswordForm extends StatefulWidget {
  final String contact;
  const ResetPasswordForm({super.key, required this.contact});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> with FormStateMixin {
  @override
  void initState() {
    super.initState();
    form.controllers[0].text = widget.contact;
  }

  @override
  int numberOfFields() {
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form.key,
      child: Column(
        children: [
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
          12.verticalSpace,
          AuthTextFieldItem(
            controller: form.controllers[1],
            title: LocaleKeys.newPassword.tr(),
            hint: LocaleKeys.enterYourPassword.tr(),
            prefixIcon: Icons.lock_outlined,
            isFieldObscure: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: LocaleKeys.fieldRequired.tr()),
              FormBuilderValidators.password(
                minLowercaseCount: 1,
                minNumberCount: 1,
                minLength: 8,
                minSpecialCharCount: 0,
                minUppercaseCount: 0,
                checkNullOrEmpty: true,
                errorText: LocaleKeys.passwordMustBe8Chars.tr(),
              ),
            ]),
          ),
          12.verticalSpace,
          AuthTextFieldItem(
            controller: form.controllers[2],
            title: LocaleKeys.confirmPassword.tr(),
            hint: LocaleKeys.enterYourPassword.tr(),
            isFieldObscure: true,
            prefixIcon: Icons.lock_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.fieldRequired.tr();
              }
              if (value != form.controllers[1].text) {
                return LocaleKeys.passwordsDoNotMatch.tr();
              }
              return null;
            },
          ),
          32.verticalSpace,
          BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state.resetState == RequestState.error) {
                final message = state.resetError ?? LocaleKeys.defaultError.tr();
                showToast(message: message, isError: true);
              }
              if (state.resetState == RequestState.success) {
                showToast(message: LocaleKeys.passwordUpdatedSuccessfully.tr());
                context.router.replace(const LoginRoute());
              }
            },
            builder: (context, state) {
              return PrimaryButton(
                text: LocaleKeys.resetPassword.tr(),
                isLoading: state.resetState == RequestState.loading,
                onPressed: () {
                  if (form.key.currentState!.validate()) {
                    final contact = form.controllers[0].text.trim();
                    final password = form.controllers[1].text;
                    context.read<ForgetPasswordCubit>().resetPassword(contact, password);
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
