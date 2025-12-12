import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import '../../../../../../app/resources/assets_manager.dart';
import '../../../../../../app/resources/color_manager.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, curr) =>
          prev.categoryDetailsState != curr.categoryDetailsState ||
          prev.categoryDetails != curr.categoryDetails ||
          prev.isLoadMore != curr.isLoadMore,
      builder: (context, state) {
        if (state.categoryDetailsState == RequestState.loading && !state.isLoadMore && state.categoryDetails.isEmpty) {
          return const _PopularPlacesSkeleton();
        }

        final items = state.categoryDetails;

        if (items.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverList.builder(
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == items.length) {
              return state.isLoadMore
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: const Center(child: LoadingWidget()),
                    )
                  : const SizedBox.shrink();
            }

            return _PopularPlaceCard(place: items[index]);
          },
        );
      },
    );
  }
}

class _PopularPlacesSkeleton extends StatelessWidget {
  const _PopularPlacesSkeleton();

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: RedactedBox(
            child: Container(
              decoration: BoxDecoration(color: ColorManager.white, borderRadius: BorderRadius.circular(14)),
              height: 220.h,
            ),
          ),
        );
      },
    );
  }
}

class _PopularPlaceCard extends StatelessWidget {
  const _PopularPlaceCard({required this.place});

  final CategoryDetailsModel place;

  @override
  Widget build(BuildContext context) {
    final imageUrl = place.image;
    final hasLocation = place.location?.latitude != null && place.location?.longitude != null;
    final address = place.address ?? place.location?.address ?? "";

    return GestureDetector(
      onTap: () => context.router.push(CategoryItemDetialsRoute(subCategoryId: place.main ?? "", itemId: place.id)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: ColorManager.black.withValues(alpha: 0.1), blurRadius: 6, offset: const Offset(0, 3)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: AspectRatio(
                aspectRatio: 16 / 8,
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? CachedImage(url: imageUrl, width: double.infinity, fit: BoxFit.cover)
                    : Image.asset(ImageManager.emptyPhoto, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            15.h.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          place.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      // Rating is commented out until API provides it.
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: ColorManager.reatingAvaterColor,
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(IconManager.star),
                      //       SizedBox(width: 4.w),
                      //       Text('4.5', style: Theme.of(context).textTheme.headlineMedium),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  8.h.verticalSpace,
                  // Type is commented until the API returns it.
                  // Text(place.type ?? "", style: Theme.of(context).textTheme.headlineSmall),
                  // 8.h.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(IconManager.location, color: ColorManager.grey),
                            SizedBox(width: 4.w),
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
                      ),
                      // Reviews are commented until API provides them.
                      // Text('225 reviews', style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                  12.h.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: hasLocation
                              ? () => getIt<LocationService>().openLocationInMaps(
                                  latitude: place.location!.latitude!,
                                  longitude: place.location!.longitude!,
                                )
                              : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: hasLocation ? ColorManager.primary : ColorManager.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  IconManager.location,
                                  colorFilter: ColorFilter.mode(ColorManager.white, BlendMode.srcIn),
                                  width: 16.w,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  LocaleKeys.directions.tr(),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 8.horizontalSpace,
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      //   decoration: BoxDecoration(
                      //     color: ColorManager.white,
                      //     border: Border.all(color: ColorManager.green.withValues(alpha: 0.3)),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: SvgPicture.asset(IconManager.phone, width: 20.w, height: 20.h),
                      //   // Phone action is commented until the API returns numbers.
                      // ),
                    ],
                  ),
                  12.h.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
