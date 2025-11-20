import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class UploadProfileImage extends StatefulWidget {
  const UploadProfileImage({super.key});

  @override
  State<UploadProfileImage> createState() => _UploadProfileImageState();
}

class _UploadProfileImageState extends State<UploadProfileImage> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickProfileImage() async {
    try {
      final XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 85, maxWidth: 1024);

      if (file == null) return;

      setState(() {
        _selectedImage = File(file.path);
      });
    } catch (error) {
      debugPrint('Failed to select profile image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius previewRadius = BorderRadius.circular(16.r);

    return Column(
      children: [
        if (_selectedImage != null)
          GestureDetector(
            onTap: _pickProfileImage,
            child: ClipRRect(
              borderRadius: previewRadius,
              child: SizedBox(
                height: 130.w,
                width: 130.w,
                child: Image.file(_selectedImage!, fit: BoxFit.cover),
              ),
            ),
          )
        else
          Image.asset(ImageManager.profile),
        12.verticalSpace,
        GestureDetector(
          onTap: _pickProfileImage,
          child: Container(
            width: 0.55.sw,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: ColorManager.blackSwatch[3]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  IconManager.upload,
                  colorFilter: ColorFilter.mode(ColorManager.black, BlendMode.srcIn),
                  width: 18.w,
                  height: 18.h,
                ),
                8.horizontalSpace,
                Text(
                  LocaleKeys.uploadProfileImage.tr(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
