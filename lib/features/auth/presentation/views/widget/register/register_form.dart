import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/form_state_mixin.dart';
import 'package:lawaen/app/core/utils/form_utils.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lawaen/features/auth/presentation/views/widget/auth_text_field_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class RegisterForm extends StatefulWidget {
  final AuthCubit authCubit;
  const RegisterForm({super.key, required this.authCubit});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with FormStateMixin {
  @override
  int numberOfFields() {
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form.key,
      child: Column(
        children: [
          AuthTextFieldItem(
            controller: form.controllers[0],
            title: LocaleKeys.name.tr(),
            hint: LocaleKeys.enterYourName.tr(),
            prefixIcon: Icons.person_outlined,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: LocaleKeys.fieldRequired.tr()),
            ]),
          ),
          12.verticalSpace,
          AuthTextFieldItem(
            controller: form.controllers[1],
            title: LocaleKeys.phoneNumberOrEmail.tr(),
            hint: LocaleKeys.enterEmailOrPhoneNumber.tr(),
            prefixIcon: Icons.email_outlined,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: LocaleKeys.fieldRequired.tr()),
            ]),
          ),
          12.verticalSpace,
          AuthTextFieldItem(
            controller: form.controllers[2],
            title: LocaleKeys.password.tr(),
            hint: LocaleKeys.enterYourPassword.tr(),
            prefixIcon: Icons.lock_outlined,
            isFieldObscure: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: LocaleKeys.fieldRequired.tr()),
              FormBuilderValidators.password(
                minUppercaseCount: 1,
                minLowercaseCount: 1,
                minSpecialCharCount: 1,
                minNumberCount: 1,
                minLength: 8,
                errorText: LocaleKeys.passwordMustBe8Chars.tr(),
              ),
            ]),
          ),
          12.verticalSpace,
          AuthTextFieldItem(
            controller: form.controllers[3],
            title: LocaleKeys.confirmPassword.tr(),
            hint: LocaleKeys.enterYourPassword.tr(),
            isFieldObscure: true,
            prefixIcon: Icons.lock_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.fieldRequired.tr();
              }
              if (value != form.controllers[2].text) {
                return LocaleKeys.passwordsDoNotMatch.tr();
              }
              return null;
            },
          ),
          32.verticalSpace,
          BlocConsumer<AuthCubit, AuthState>(
            bloc: widget.authCubit,
            listener: (context, state) {
              if (state is AuthSuccess) {
                context.router.pushAndPopUntil(NavigationControllerRoute(), predicate: (route) => false);
              }
              if (state is AuthFailure) {
                showToast(message: state.errorMessage);
              }
            },
            builder: (context, state) {
              return PrimaryButton(
                isLoading: state is AuthLoading,
                text: LocaleKeys.signIn.tr(),
                onPressed: () {
                  if (form.key.currentState!.validate()) {
                    final name = form.controllers[0].text;
                    final emailOrPhoneNumber = form.controllers[1].text;
                    final password = form.controllers[2].text;
                    if (emailOrPhoneNumber.contains('@')) {
                      widget.authCubit.register(email: emailOrPhoneNumber, password: password, name: name);
                    } else {
                      widget.authCubit.register(phoneNumber: emailOrPhoneNumber, password: password, name: name);
                    }
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
