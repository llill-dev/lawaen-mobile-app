import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';

class RatingsItme extends StatelessWidget {
  final CategoryDetailsModel ratingItemModel;
  final bool isGridView;
  final String? userName;
  final VoidCallback? onLocationTap;
  const RatingsItme({
    super.key,
    required this.ratingItemModel,
    this.isGridView = false,
    this.userName,
    this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    final locationText = ratingItemModel.location?.address ?? ratingItemModel.address ?? "";
    final hasLocation = ratingItemModel.location?.latitude != null && ratingItemModel.location?.longitude != null;

    return GestureDetector(
      onTap: () => context.pushRoute(
        CategoryItemDetialsRoute(itemId: ratingItemModel.id, subCategoryId: ratingItemModel.main ?? ""),
      ),
      child: Container(
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
                  _ItemImage(imageUrl: ratingItemModel.image, width: double.infinity, height: 100.h),
                  12.verticalSpace,
                  if (userName != null && userName!.isNotEmpty)
                    Text(
                      userName!,
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  6.verticalSpace,
                  Text(
                    ratingItemModel.name ?? "",
                    style: Theme.of(context).textTheme.headlineMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      if (locationText.isNotEmpty)
                        Flexible(
                          child: Text(
                            locationText,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (hasLocation)
                        IconButton(
                          onPressed: onLocationTap,
                          icon: Icon(Icons.location_on_outlined, color: ColorManager.grey),
                        ),
                    ],
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ItemImage(imageUrl: ratingItemModel.image, width: 90.w, height: 90.h),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (userName != null && userName!.isNotEmpty)
                          Text(
                            userName!,
                            style: Theme.of(context).textTheme.labelLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        4.verticalSpace,
                        Text(
                          ratingItemModel.name ?? "",
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (locationText.isNotEmpty)
                              Flexible(
                                child: Text(
                                  locationText,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            if (hasLocation)
                              IconButton(
                                onPressed: onLocationTap,
                                icon: Icon(Icons.location_on_outlined, color: ColorManager.grey, size: 22),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _ItemImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  const _ItemImage({this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    final fallback = Image.asset(ImageManager.emptyPhoto, width: width, height: height, fit: BoxFit.cover);
    if (imageUrl == null || imageUrl!.isEmpty) return fallback;

    return Image.network(
      imageUrl!,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}
