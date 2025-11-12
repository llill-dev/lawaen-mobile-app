import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class MuneItemModel {
  final String title;
  final String price;
  final String description;
  final String tag;
  final Color tagColor;
  final String image;

  MuneItemModel({
    required this.title,
    required this.price,
    required this.description,
    required this.tag,
    required this.tagColor,
    required this.image,
  });
}

class MuneItme extends StatelessWidget {
  final MuneItemModel item;
  const MuneItme({super.key, required this.item});

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
              child: Image.asset(item.image, fit: BoxFit.cover, width: double.infinity),
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
                    Text(item.title, style: Theme.of(context).textTheme.headlineLarge),
                    Text(item.price, style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
                12.verticalSpace,
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.darkGrey),
                ),
                12.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(color: item.tagColor, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(IconManager.mune, width: 12.w, height: 12.w),
                      4.horizontalSpace,
                      Text(
                        item.tag,
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
