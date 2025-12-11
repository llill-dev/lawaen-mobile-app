import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/utils/form_state_mixin.dart';
import 'package:lawaen/app/core/utils/form_utils.dart';
import 'package:lawaen/app/core/widgets/app_date_picker_widget.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/features/auth/data/models/basic_user_info_model.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_container.dart';
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

  final AppPreferences _prefs = getIt<AppPreferences>();
  final ImagePicker _imagePicker = ImagePicker();

  BasicUserInfo? _user;
  File? _profileImage;
  String? _fullName;
  String? _phoneNumber;
  String? _selectedGender;
  String? _birthDate;

  @override
  void initState() {
    super.initState();
    _user = _prefs.getUserInfo();
    _fullName = _user?.name;
    _phoneNumber = _user?.emailOrPhone;

    form.controllers[_fullNameIndex].text = _fullName ?? "";
    form.controllers[_phoneIndex].text = _phoneNumber ?? "";
  }

  @override
  int numberOfFields() => 2;

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
    return Scaffold(
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
                DropDownItem(
                  title: "selcet your gender",
                  items: const ["male", "femal"],
                  initialValue: _selectedGender,
                  onChanged: (value) => setState(() => _selectedGender = value),
                ),
                12.verticalSpace,
                AppDatePickerField(
                  title: "your Birth Date",
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
                TextFiledItem(title: "upload profile photo", readOnly: true, onTap: _pickProfileImage),

                24.verticalSpace,
                PrimaryButton(
                  isLight: true,
                  withShadow: true,
                  text: "chagne password",
                  borederColor: ColorManager.primary,
                ),
                12.verticalSpace,
                PrimaryButton(text: "update Profile", withShadow: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
