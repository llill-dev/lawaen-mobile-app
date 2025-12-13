import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/mune_model.dart';

class MuneItemWidget extends StatelessWidget {
  final String muneCategoryTitle;
  final MenuItem item;
  const MuneItemWidget({super.key, required this.item, required this.muneCategoryTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: .25),
            spreadRadius: -1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: AspectRatio(
              aspectRatio: 16 / 8,
              child: item.image != null && item.image!.isNotEmpty
                  ? CachedImage(url: item.image!, fit: BoxFit.cover, width: double.infinity)
                  : Image.asset(ImageManager.emptyPhoto, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          24.verticalSpace,

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.title ?? "", style: Theme.of(context).textTheme.headlineLarge),
                    if (item.price != null)
                      Text(item.price.toString(), style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
                12.verticalSpace,
                Text(
                  item.description ?? "",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.darkGrey),
                ),
                12.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(color: ColorManager.muneGreen, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(IconManager.mune, width: 12.w, height: 12.w),
                      4.horizontalSpace,
                      Text(
                        muneCategoryTitle,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(color: ColorManager.black, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
