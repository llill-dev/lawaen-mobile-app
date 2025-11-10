import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class PhotosSection extends StatelessWidget {
  final List<String> photos;
  final String mainPhoto;
  final int maxDisplayPhotos;

  const PhotosSection({super.key, required this.photos, required this.mainPhoto, this.maxDisplayPhotos = 3});

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) return const SizedBox();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 200.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(mainPhoto, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
        ),

        8.horizontalSpace,
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 200.h,
            child: Column(children: _buildPhotoColumnWithMoreIndicator(context)),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPhotoColumnWithMoreIndicator(BuildContext context) {
    List<Widget> columnChildren = [];
    int displayCount = photos.length > maxDisplayPhotos ? maxDisplayPhotos - 1 : photos.length;

    for (int i = 0; i < displayCount; i++) {
      columnChildren.add(
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(photos[i], fit: BoxFit.cover, width: double.infinity),
          ),
        ),
      );

      if (i < displayCount - 1) {
        columnChildren.add(4.verticalSpace);
      }
    }
    if (photos.length > maxDisplayPhotos) {
      if (displayCount > 0) {
        columnChildren.add(4.verticalSpace);
      }

      columnChildren.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: ColorManager.lightGrey),
            child: Center(
              child: Text('+${photos.length - displayCount}', style: Theme.of(context).textTheme.labelMedium),
            ),
          ),
        ),
      );
    }

    return columnChildren;
  }
}
