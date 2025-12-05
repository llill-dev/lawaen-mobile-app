import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';
import 'add_container.dart';

class UploadImage extends StatefulWidget {
  final File? imageFile;
  final Function(File) onImageSelected;

  const UploadImage({super.key, required this.imageFile, required this.onImageSelected});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85, maxWidth: 1080);

      if (picked == null) return;

      setState(() {
        final file = File(picked.path);
        widget.onImageSelected(file);
      });
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddContainer(
      child: Column(
        children: [
          // If image uploaded, show preview
          if (widget.imageFile != null)
            GestureDetector(
              onTap: _pickImage,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.file(widget.imageFile!, width: double.infinity, height: 180.h, fit: BoxFit.cover),
              ),
            )
          else
            Column(
              children: [
                SvgPicture.asset(IconManager.upload),
                12.verticalSpace,
                Text(
                  LocaleKeys.uploadYourImage.tr(),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: ColorManager.green),
                ),
                12.verticalSpace,
                Text(
                  LocaleKeys.uploadImageNote.tr(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.red),
                ),
              ],
            ),

          16.verticalSpace,

          // Button to replace/change image
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(color: ColorManager.blackSwatch[3], borderRadius: BorderRadius.circular(10.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    IconManager.upload,
                    width: 18.w,
                    height: 18.h,
                    colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                  8.horizontalSpace,
                  Text(
                    widget.imageFile == null ? LocaleKeys.uploadYourImage.tr() : LocaleKeys.replaceYourImage.tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
