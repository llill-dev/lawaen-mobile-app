import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/category_item_details_cubit/category_item_detials_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class ClaimScreen extends StatefulWidget {
  final String itemId;
  final String secondCategoryId;
  const ClaimScreen({super.key, required this.itemId, required this.secondCategoryId});

  @override
  State<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];
  final CategoryItemDetialsCubit cubit = getIt<CategoryItemDetialsCubit>();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  static const int maxImages = 4;

  Future<void> _pickImages() async {
    if (_images.length >= maxImages) return;

    final picked = await _picker.pickMultiImage(imageQuality: 85, maxWidth: 1080);

    if (picked.isEmpty) return;

    setState(() {
      for (final xFile in picked) {
        if (_images.length < maxImages) {
          _images.add(File(xFile.path));
        }
      }
    });
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryBackButton(iconOnlay: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.claimFormMessage.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: ColorManager.primary),
                  ).horizontalPadding(padding: 16.w),
                ],
              ),
              24.verticalSpace,

              ClaimForm(phoneController: _phoneController, noteController: _noteController),
              24.verticalSpace,

              // Text(
              //   LocaleKeys.claimDocuments.tr(namedArgs: {'count': '0'}),
              //   style: Theme.of(context).textTheme.headlineMedium,
              // ).horizontalPadding(padding: 16.w),
              // 24.verticalSpace,
              if (_images.isNotEmpty)
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: List.generate(
                    _images.length,
                    (index) => ClaimImageItem(image: _images[index], onDelete: () => _removeImage(index)),
                  ),
                ).horizontalPadding(padding: 16.w),

              24.verticalSpace,

              Center(
                child: ClaimUploadContainer(
                  onTap: _pickImages,
                  isDisabled: _images.length >= maxImages,
                ).horizontalPadding(padding: 16.w),
              ),

              24.verticalSpace,

              BlocConsumer<CategoryItemDetialsCubit, CategoryItemDetialsState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state.claimItemState == RequestState.error) {
                    showToast(message: state.globalError ?? LocaleKeys.defaultError.tr(), isError: true);
                  }
                  if (state.claimItemState == RequestState.success) {
                    Navigator.pop(context);
                  }
                },

                builder: (context, state) {
                  return PrimaryButton(
                    text: LocaleKeys.submit.tr(),
                    isLoading: state.claimItemState == RequestState.loading,
                    onPressed: () {
                      cubit.claimItem(
                        itemId: widget.itemId,
                        secondCategoryId: widget.secondCategoryId,
                        images: _images,
                        note: _noteController.text,
                      );
                    },
                  );
                },
              ).horizontalPadding(padding: 16.w),
            ],
          ),
        ),
      ),
    );
  }
}

class ClaimForm extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController noteController;
  const ClaimForm({super.key, required this.phoneController, required this.noteController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: ColorManager.black.withValues(alpha: 0.25), offset: const Offset(0, 2), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          ClaimTextFiledItem(
            controller: phoneController,
            title: LocaleKeys.phoneNumber.tr(),
            hint: LocaleKeys.phoneNumber.tr(),
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          12.verticalSpace,
          ClaimTextFiledItem(
            controller: noteController,
            maxLines: 3,
            title: LocaleKeys.note.tr(),
            hint: LocaleKeys.note.tr(),
            icon: Icons.note_outlined,
          ),
          12.verticalSpace,
        ],
      ),
    );
  }
}

class ClaimTextFiledItem extends StatelessWidget {
  final String title;
  final String hint;
  final IconData icon;
  final bool isNote;
  final bool? readOnly;
  final int? maxLines;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const ClaimTextFiledItem({
    super.key,
    required this.title,
    required this.hint,
    required this.icon,
    this.isNote = false,
    this.readOnly,
    this.maxLines,
    this.controller,
    this.onTap,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18.r, color: ColorManager.primary),
            4.horizontalSpace,
            Text(title, style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.primary)),
          ],
        ),
        8.verticalSpace,
        CustomTextField(
          withBorder: false,
          keyboardType: keyboardType,
          readOnly: readOnly ?? false,
          controller: controller,
          onTap: onTap,
          fillColor: ColorManager.blackSwatch[3],
          hint: hint,
          borderRadius: 12.r,
          verticalContentPadding: isNote ? 16.h : 8.h,
          horizontalContentPadding: 16.w,
          maxLines: maxLines ?? (isNote ? 3 : 1),
        ),
      ],
    );
  }
}

class ClaimUploadContainer extends StatelessWidget {
  final VoidCallback onTap;
  final bool isDisabled;

  const ClaimUploadContainer({super.key, required this.onTap, this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: ColorManager.blackSwatch[3],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDisabled ? ColorManager.lightGrey : ColorManager.primary,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(Icons.upload_file_rounded, size: 32.r, color: ColorManager.primary),
            12.verticalSpace,
            Text(LocaleKeys.uploadYourImage.tr(), style: Theme.of(context).textTheme.headlineMedium),
            8.verticalSpace,
            Text(
              LocaleKeys.uploadImageNote.tr(),
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ClaimImageItem extends StatelessWidget {
  final File image;
  final VoidCallback onDelete;

  const ClaimImageItem({super.key, required this.image, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(image, width: 100.w, height: 100.w, fit: BoxFit.cover),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onDelete,
            child: Container(
              decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}
