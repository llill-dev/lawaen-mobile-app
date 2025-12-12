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
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/features/profile/presentation/cubit/update_profile_cubit_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

const int _oldPasswordIndex = 0;
const int _newPasswordIndex = 1;
const int _emailOrPhoneIndex = 2;

Future<Map<String, String>?> showChangePasswordBottomSheet(BuildContext context) {
  return showModalBottomSheet<Map<String, String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => const _ChangePasswordBottomSheet(),
  );
}

class _ChangePasswordBottomSheet extends StatefulWidget {
  const _ChangePasswordBottomSheet();

  @override
  State<_ChangePasswordBottomSheet> createState() => _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<_ChangePasswordBottomSheet> with FormStateMixin {
  @override
  int numberOfFields() => 3;

  @override
  Widget build(BuildContext context) {
    final authCubit = getIt<UpdateProfileCubit>();
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      bloc: authCubit,
      listener: (context, state) {
        if (state.changePasswordState == RequestState.success) {
          showToast(message: LocaleKeys.passwordUpdatedSuccessfully.tr(), isSuccess: true);
          context.router.pop();
        }
        if (state.changePasswordState == RequestState.error) {
          showToast(message: state.changePasswordError ?? LocaleKeys.defaultError.tr(), isError: true);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Form(
              key: form.key,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 60.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: ColorManager.blackSwatch[4],
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    12.verticalSpace,
                    Text(LocaleKeys.changePassword.tr(), style: Theme.of(context).textTheme.displayLarge),
                    16.verticalSpace,
                    TextFiledItem(
                      title: LocaleKeys.oldPassword.tr(),
                      controller: form.controllers[_oldPasswordIndex],
                      isFieldObscure: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: LocaleKeys.fieldRequired.tr()),
                      ]),
                    ),
                    12.verticalSpace,
                    TextFiledItem(
                      title: LocaleKeys.newPassword.tr(),
                      controller: form.controllers[_newPasswordIndex],
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
                    TextFiledItem(
                      title: LocaleKeys.emailOrPhone.tr(),
                      controller: form.controllers[_emailOrPhoneIndex],
                      keyboardType: TextInputType.emailAddress,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: LocaleKeys.fieldRequired.tr()),
                      ]),
                    ),
                    16.verticalSpace,
                    PrimaryButton(
                      text: LocaleKeys.submit.tr(),
                      withShadow: true,
                      isLoading: state.changePasswordState == RequestState.loading,
                      onPressed: () {
                        if (form.key.currentState?.validate() == true) {
                          authCubit.changePassword(
                            oldPassword: form.controllers[_oldPasswordIndex].text,
                            newPassword: form.controllers[_newPasswordIndex].text,
                            phoneNumberOrEmail: form.controllers[_emailOrPhoneIndex].text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
