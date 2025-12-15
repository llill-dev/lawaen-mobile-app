import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';

class FavoritesItme extends StatelessWidget {
  final bool isGridView;
  final CategoryDetailsModel favoritesItemModel;
  final VoidCallback? onLocationTap;
  final VoidCallback? onFavoriteTap;
  const FavoritesItme({
    super.key,
    required this.favoritesItemModel,
    required this.isGridView,
    this.onLocationTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final address = favoritesItemModel.address ?? favoritesItemModel.location?.address ?? '';
    final hasLocation = favoritesItemModel.location?.latitude != null && favoritesItemModel.location?.longitude != null;

    return GestureDetector(
      onTap: () {
        context.pushRoute(
          CategoryItemDetialsRoute(itemId: favoritesItemModel.id, subCategoryId: favoritesItemModel.main ?? ""),
        );
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
            ? _buildGridContent(context: context, address: address, hasLocation: hasLocation)
            : _buildListContent(context: context, address: address, hasLocation: hasLocation),
      ),
    );
  }

  Widget _buildGridContent({required BuildContext context, required String address, required bool hasLocation}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r)),
          child: _ItemImage(imageUrl: favoritesItemModel.image),
        ),
        Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                favoritesItemModel.name ?? "",
                style: Theme.of(context).textTheme.displayMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              6.verticalSpace,
              Text(
                address,
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              12.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _IconContainer(
                    onTap: onFavoriteTap,
                    child: Icon(Icons.favorite, color: ColorManager.red, size: 16),
                  ),
                  _IconContainer(
                    onTap: hasLocation ? onLocationTap : null,
                    child: Icon(
                      Icons.location_on_outlined,
                      color: hasLocation ? ColorManager.grey : ColorManager.grey.withValues(alpha: .4),
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListContent({required BuildContext context, required String address, required bool hasLocation}) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: _ItemImage(imageUrl: favoritesItemModel.image, width: 90.w, height: 90.h),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favoritesItemModel.name ?? "",
                  style: Theme.of(context).textTheme.displayMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                6.verticalSpace,
                Text(
                  address,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _IconContainer(
                      onTap: onFavoriteTap,
                      child: Icon(Icons.favorite, color: ColorManager.red, size: 16),
                    ),
                    Row(
                      children: [
                        _IconContainer(
                          onTap: hasLocation ? onLocationTap : null,
                          child: Icon(
                            Icons.location_on_outlined,
                            color: hasLocation ? ColorManager.grey : ColorManager.grey.withValues(alpha: .4),
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
      width: width ?? double.infinity,
      height: height ?? 120.h,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}

class _IconContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const _IconContainer({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(8.r)),
        child: child,
      ),
    );
  }
}
