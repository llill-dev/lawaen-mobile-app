import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';

import '../../../../../../app/resources/color_manager.dart';

class CategoryDetailsItem extends StatelessWidget {
  final CategoryDetailsModel categoryDetailsModel;
  const CategoryDetailsItem({super.key, required this.categoryDetailsModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(
        CategoryItemDetialsRoute(itemId: categoryDetailsModel.id, subCategoryId: categoryDetailsModel.main ?? ""),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.borderColor),
          color: ColorManager.white,
          boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: .15), blurRadius: 3, offset: Offset(0, 1))],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: categoryDetailsModel.image.isEmpty
                  ? Image.asset(ImageManager.emptyPhoto, width: 50.w, height: 50.h, fit: BoxFit.fill)
                  : CachedImage(width: 50.w, height: 50.h, url: categoryDetailsModel.image, fit: BoxFit.fill),
            ),
            18.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryDetailsModel.name ?? "",
                    style: Theme.of(context).textTheme.headlineMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  8.verticalSpace,
                  if (categoryDetailsModel.address != null)
                    Row(
                      children: [
                        SvgPicture.asset(IconManager.location, color: ColorManager.green),
                        2.horizontalSpace,
                        Flexible(
                          child: Text(
                            categoryDetailsModel.address!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.green),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ).horizontalPadding(padding: 16.w),
    );
  }
}
