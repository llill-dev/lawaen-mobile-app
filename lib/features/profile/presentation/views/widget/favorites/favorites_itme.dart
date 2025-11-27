import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';

class FavoritesItme extends StatelessWidget {
  final bool isGridView;
  final FavoritesItemModel favoritesItemModel;
  const FavoritesItme({super.key, required this.favoritesItemModel, required this.isGridView});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(CategoryItemDetialsRoute(itemId: "", subCategoryId: ""));
      },
      child: Container(
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
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r)),
                    child: Image.asset(
                      favoritesItemModel.imageUrl,
                      width: double.infinity,
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          favoritesItemModel.title,
                          style: Theme.of(context).textTheme.displayMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        6.verticalSpace,
                        Text(
                          favoritesItemModel.details,
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        4.verticalSpace,
                        Text(
                          favoritesItemModel.isClosed ? "Close" : "Open",
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: favoritesItemModel.isClosed ? ColorManager.red : ColorManager.green,
                              ) ??
                              TextStyle(color: favoritesItemModel.isClosed ? ColorManager.red : ColorManager.green),
                        ),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _IconContainer(child: Icon(Icons.favorite, color: ColorManager.red, size: 16)),
                            _IconContainer(child: Icon(Icons.share, color: ColorManager.grey, size: 16)),
                            _IconContainer(child: Icon(Icons.location_on_outlined, color: ColorManager.grey, size: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
                    child: Image.asset(favoritesItemModel.imageUrl, fit: BoxFit.cover, width: 90.w, height: 90.h),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(favoritesItemModel.title, style: Theme.of(context).textTheme.displayMedium),
                        4.verticalSpace,
                        Text(favoritesItemModel.details, style: Theme.of(context).textTheme.headlineSmall),
                        6.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              favoritesItemModel.isClosed ? "Close" : "Open",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: favoritesItemModel.isClosed ? ColorManager.red : ColorManager.green,
                              ),
                            ),
                            Row(
                              children: [
                                _IconContainer(child: Icon(Icons.favorite, color: ColorManager.red, size: 16)),
                                6.horizontalSpace,
                                _IconContainer(child: Icon(Icons.share, color: ColorManager.grey, size: 16)),
                                6.horizontalSpace,
                                _IconContainer(
                                  child: Icon(Icons.location_on_outlined, color: ColorManager.grey, size: 16),
                                ),
                              ],
                            ).horizontalPadding(padding: 16.w),
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

class FavoritesItemModel {
  final String title;
  final String details;
  final String imageUrl;
  final bool isClosed;
  FavoritesItemModel({required this.title, required this.details, required this.imageUrl, required this.isClosed});
}

class _IconContainer extends StatelessWidget {
  final Widget child;
  const _IconContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(8.r)),
      child: child,
    );
  }
}
