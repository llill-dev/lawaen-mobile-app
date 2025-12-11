import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/utils/form_state_mixin.dart';
import 'package:lawaen/app/core/utils/form_utils.dart';
import 'package:lawaen/app/core/widgets/app_date_picker_widget.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/features/auth/data/models/basic_user_info_model.dart';
import 'package:lawaen/features/auth/presentation/params/update_profile_params.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_container.dart';
import 'package:lawaen/features/profile/presentation/cubit/update_profile_cubit_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> with FormStateMixin {
  static const int _fullNameIndex = 0;
  static const int _phoneIndex = 1;
  static const int _emailIndex = 2;

  final AppPreferences _prefs = getIt<AppPreferences>();
  final ImagePicker _imagePicker = ImagePicker();
  final UpdateProfileCubit cubit = getIt<UpdateProfileCubit>();

  BasicUserInfo? _user;
  File? _profileImage;
  String? _fullName;
  String? _phoneNumber;
  String? _selectedGender;
  String? _birthDate;
  String? _email;

  @override
  void initState() {
    super.initState();
    _user = _prefs.getUserInfo();
    _fullName = _user?.name;
    _phoneNumber = _user?.phone;
    _email = _user?.email;

    form.controllers[_fullNameIndex].text = _fullName ?? "";
    form.controllers[_phoneIndex].text = _phoneNumber ?? "";
    form.controllers[_emailIndex].text = _email ?? "";
  }

  @override
  int numberOfFields() => 3;

  void _onImageSelected(File file) {
    setState(() {
      _profileImage = file;
    });
  }

  Future<void> _pickProfileImage() async {
    try {
      final XFile? picked = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 85, maxWidth: 1080);
      if (picked == null) return;
      _onImageSelected(File(picked.path));
    } catch (e) {
      debugPrint("Error picking profile image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String name = _fullName ?? "";
    final String? imageUrl = _user?.image;
    final bool hasImage = imageUrl != null && imageUrl.isNotEmpty;
    final Map<String, String> genderLabels = {
      "male": LocaleKeys.genderMale.tr(),
      "female": LocaleKeys.genderFemale.tr(),
    };
    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.updateError != null || state.updateState == RequestState.error) {
          showToast(message: state.updateError ?? LocaleKeys.defaultError.tr(), isError: true);
        }

        if (state.updateState == RequestState.success) {
          showToast(message: LocaleKeys.success.tr(), isSuccess: true);
          context.router.pushAndPopUntil(NavigationControllerRoute(), predicate: (route) => false);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: form.key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeAppBarContainer(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.router.pop(),
                          child: Icon(Icons.arrow_back_ios_new_outlined, color: ColorManager.white),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              if (_profileImage != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.file(_profileImage!, width: 50.w, height: 50.w, fit: BoxFit.cover),
                                )
                              else if (hasImage)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: CachedImage(
                                    url: imageUrl,
                                    width: 50.w,
                                    height: 50.w,
                                    radius: BorderRadius.circular(40),
                                  ),
                                )
                              else
                                Image.asset(ImageManager.profile, color: ColorManager.white, width: 50.w, height: 50.w),

                              8.verticalSpace,
                              Text(
                                name,
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  24.verticalSpace,

                  TextFiledItem(
                    title: LocaleKeys.fullName.tr(),
                    controller: form.controllers[_fullNameIndex],
                    onChanged: (value) => setState(() => _fullName = value),
                  ),
                  12.verticalSpace,

                  TextFiledItem(
                    title: LocaleKeys.phoneNumber.tr(),
                    controller: form.controllers[_phoneIndex],
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => _phoneNumber = value,
                  ),
                  12.verticalSpace,

                  TextFiledItem(
                    title: LocaleKeys.emailAddress.tr(),
                    controller: form.controllers[_emailIndex],
                    onChanged: (value) => _email = value,
                  ),
                  12.verticalSpace,

                  DropDownItem(
                    title: LocaleKeys.selectYourGender.tr(),
                    items: const ["male", "female"],
                    itemLabelBuilder: (value) => genderLabels[value] ?? value,
                    initialValue: _selectedGender,
                    onChanged: (value) => setState(() => _selectedGender = value),
                  ),
                  12.verticalSpace,

                  AppDatePickerField(
                    title: LocaleKeys.yourBirthDate.tr(),
                    value: _birthDate,
                    onDateSelected: (date) {
                      final formattedDate =
                          "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                      setState(() {
                        _birthDate = formattedDate;
                      });
                    },
                  ),

                  12.verticalSpace,
                  TextFiledItem(title: LocaleKeys.uploadProfilePhoto.tr(), readOnly: true, onTap: _pickProfileImage),

                  24.verticalSpace,
                  PrimaryButton(
                    isLight: true,
                    withShadow: true,
                    text: LocaleKeys.changePassword.tr(),
                    borederColor: ColorManager.primary,
                  ),

                  12.verticalSpace,
                  BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return PrimaryButton(
                        text: LocaleKeys.updateProfile.tr(),
                        withShadow: true,
                        isLoading: state.updateState == RequestState.loading,
                        onPressed: () {
                          cubit.updateProfile(
                            params: UpdateProfileParams(
                              name: _fullName,
                              phoneNumber: _phoneNumber,
                              gender: _selectedGender,
                              birthDate: _birthDate,
                              profileImage: _profileImage,
                              email: _email,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
