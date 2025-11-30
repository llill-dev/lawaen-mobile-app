import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/generated/locale_keys.g.dart';
import 'gallery_viewer.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class PhotosSection extends StatelessWidget {
  final List<String> photos;
  final int maxDisplayPhotos;

  const PhotosSection({super.key, required this.photos, this.maxDisplayPhotos = 3});

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return Center(child: Text(LocaleKeys.notFound.tr(), style: Theme.of(context).textTheme.headlineMedium));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MAIN PHOTO
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: () => _openGallery(context, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: NetworkIcon(url: photos.first, fit: BoxFit.fill, width: double.infinity, height: 200.h),
            ),
          ),
        ),

        8.horizontalSpace,

        // SIDE PHOTOS COLUMN
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 200.h,
            child: Column(children: _buildSideImages(context)),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSideImages(BuildContext context) {
    final int displayCount = photos.length > maxDisplayPhotos ? maxDisplayPhotos : photos.length;

    List<Widget> children = [];

    for (int i = 1; i < displayCount; i++) {
      children.add(
        Expanded(
          child: GestureDetector(
            onTap: () => _openGallery(context, i),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: NetworkIcon(url: photos[i], fit: BoxFit.cover, width: double.infinity),
            ),
          ),
        ),
      );

      if (i != displayCount - 1) children.add(4.verticalSpace);
    }

    // "+X more" indicator
    if (photos.length > maxDisplayPhotos) {
      if (children.isNotEmpty) children.add(4.verticalSpace);

      children.add(
        Expanded(
          child: GestureDetector(
            onTap: () => _openGallery(context, 0),
            child: Container(
              decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(10.r)),
              child: Center(
                child: Text("+${photos.length - (displayCount - 1)}", style: Theme.of(context).textTheme.labelMedium),
              ),
            ),
          ),
        ),
      );
    }

    return children;
  }

  void _openGallery(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => GalleryViewer(images: photos, initialIndex: index),
    );
  }
}
