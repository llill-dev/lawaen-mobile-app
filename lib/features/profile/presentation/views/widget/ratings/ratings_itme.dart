import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class RatingsItme extends StatelessWidget {
  final RatingItemModel ratingItemModel;
  final bool isGridView;
  const RatingsItme({super.key, required this.ratingItemModel, this.isGridView = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: isGridView ? null : EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorManager.borderColor),
        boxShadow: [
          BoxShadow(color: ColorManager.black.withValues(alpha: .1), blurRadius: 10, offset: const Offset(5, 3.5)),
        ],
      ),
      child: isGridView
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(ratingItemModel.imageUrl, fit: BoxFit.cover, width: 60.w, height: 60.h),
                    12.horizontalSpace,
                    Flexible(child: Text(ratingItemModel.title, style: Theme.of(context).textTheme.headlineMedium)),
                  ],
                ),
                14.verticalSpace,
                Text(
                  ratingItemModel.description,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(ratingItemModel.imageUrl, fit: BoxFit.cover, width: 90.w, height: 90.h),
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ratingItemModel.title, style: Theme.of(context).textTheme.headlineMedium),
                      8.verticalSpace,
                      Text(ratingItemModel.description, style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class RatingItemModel {
  final String title;
  final String description;
  final String imageUrl;
  RatingItemModel({required this.title, required this.description, required this.imageUrl});
}
