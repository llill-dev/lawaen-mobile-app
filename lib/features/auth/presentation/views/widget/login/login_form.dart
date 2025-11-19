import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lawaen/app/core/utils/form_state_mixin.dart';
import 'package:lawaen/app/core/utils/form_utils.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
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
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: LocaleKeys.fieldRequired.tr()),
            ]),
          ),
          32.verticalSpace,
          PrimaryButton(
            text: LocaleKeys.signIn.tr(),
            onPressed: () {
              if (form.key.currentState!.validate()) {}
            },
            height: 40.h,
          ),
        ],
      ),
    );
  }
}
