import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class ExploreItem extends StatelessWidget {
  const ExploreItem({super.key, required this.item, this.isGridView = true});

  final CategoryDetailsModel item;
  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.image;
    final address = item.address ?? item.location?.address ?? "";

    return GestureDetector(
      onTap: () => context.pushRoute(CategoryItemDetialsRoute(itemId: item.id, subCategoryId: item.main ?? "")),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 0.1),
              offset: const Offset(0, 1),
              spreadRadius: -1,
              blurRadius: 2,
            ),

            BoxShadow(color: ColorManager.black.withValues(alpha: 0.25), offset: const Offset(0, 1), blurRadius: 4),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: ColorManager.red, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconManager.trending),
                        4.horizontalSpace,
                        Text(
                          LocaleKeys.trending.tr(),
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                      child: AspectRatio(
                        aspectRatio: isGridView ? 16 / 10 : 16 / 7,
                        child: imageUrl != null && imageUrl.isNotEmpty
                            ? CachedImage(url: imageUrl, fit: BoxFit.cover, width: double.infinity)
                            : Image.asset(ImageManager.emptyPhoto, width: double.infinity, fit: BoxFit.cover),
                      ),
                    ),
                    16.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name ?? "",
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.black),
                        ),
                        4.verticalSpace,
                        if (address.isNotEmpty)
                          Row(
                            children: [
                              SvgPicture.asset(IconManager.location, color: ColorManager.grey),
                              6.horizontalSpace,
                              Expanded(
                                child: Text(
                                  address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ],
                          ),
                        4.verticalSpace,
                        // Rating is commented out until the API provides it.
                        // Row(
                        //   children: [
                        //     SvgPicture.asset(IconManager.star),
                        //     6.horizontalSpace,
                        //     Text('4.5', style: Theme.of(context).textTheme.headlineSmall),
                        //   ],
                        // ),
                        if (!isGridView) 12.verticalSpace,
                      ],
                    ).horizontalPadding(padding: 16.w),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
