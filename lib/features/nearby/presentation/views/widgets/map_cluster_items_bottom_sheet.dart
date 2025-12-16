import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';

class MapClusterItemsBottomSheet extends StatelessWidget {
  final List<CategoryDetailsModel> items;

  const MapClusterItemsBottomSheet({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.6;

    return SafeArea(
      child: SizedBox(
        height: height,
        child: Container(
          decoration: const BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              SizedBox(height: 12.h),

              /// Drag Handle
              Container(
                width: 94.w,
                height: 4.h,
                decoration: BoxDecoration(color: ColorManager.blackSwatch[4], borderRadius: BorderRadius.circular(10)),
              ),

              SizedBox(height: 16.h),

              /// LIST (ONLY THIS SCROLLS)
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {
                        context.router.pop();
                        context.router.push(CategoryItemDetialsRoute(subCategoryId: item.main!, itemId: item.id));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// IMAGE
                          if (item.image != null && item.image!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: CachedImage(url: item.image, width: 64.w, height: 64.w, fit: BoxFit.cover),
                            )
                          else
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.asset(ImageManager.emptyPhoto, width: 64.w, height: 64.w, fit: BoxFit.cover),
                            ),

                          SizedBox(width: 12.w),

                          /// NAME + ADDRESS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// NAME
                                Text(
                                  item.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
                                ),

                                SizedBox(height: 6.h),

                                /// ADDRESS
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      IconManager.location,
                                      width: 18,
                                      height: 18,
                                      colorFilter: const ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
                                    ),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Text(
                                        item.address ?? item.location?.address ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: ColorManager.white.withOpacity(0.85),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
