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
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lawaen/features/auth/presentation/views/widget/auth_text_field_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with FormStateMixin {
  @override
  int numberOfFields() {
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = getIt<AuthCubit>();
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
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: LocaleKeys.fieldRequired.tr()),
            ]),
          ),
          12.verticalSpace,
          AuthTextFieldItem(
            controller: form.controllers[1],
            title: LocaleKeys.password.tr(),
            hint: LocaleKeys.enterYourPassword.tr(),
            prefixIcon: Icons.lock_outlined,
            isFieldObscure: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: LocaleKeys.fieldRequired.tr()),
            ]),
          ),
          32.verticalSpace,
          BlocConsumer<AuthCubit, AuthState>(
            bloc: authCubit,
            listener: (context, state) {
              if (state is AuthFailure) {
                showToast(message: state.errorMessage);
              }
              if (state is AuthSuccess) {
                context.router.pushAndPopUntil(NavigationControllerRoute(), predicate: (route) => false);
              }
            },
            builder: (context, state) {
              return PrimaryButton(
                isLoading: state is AuthLoading,
                text: LocaleKeys.signIn.tr(),
                onPressed: () async {
                  if (form.key.currentState!.validate()) {
                    final emailOrPhoneNumber = form.controllers[0].text;
                    final password = form.controllers[1].text;
                    if (emailOrPhoneNumber.contains('@')) {
                      authCubit.login(email: emailOrPhoneNumber, password: password);
                    } else {
                      authCubit.login(phoneNumber: emailOrPhoneNumber, password: password);
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
