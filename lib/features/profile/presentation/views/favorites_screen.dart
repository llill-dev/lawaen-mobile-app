import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/core/widgets/error_view.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:lawaen/features/profile/presentation/views/widget/custom_profile_header_section.dart';
import 'package:lawaen/features/profile/presentation/views/widget/favorites/favorites_itme.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final isSuccess = state.getSavedState == RequestState.success;

            return CustomScrollView(
              clipBehavior: Clip.none,
              slivers: [
                CustomProfileHeaderSections(
                  tilte: LocaleKeys.favorites.tr(),
                  withBackButton: true,
                  isGridView: _isGridView,
                  showSearch: false,
                  onViewModeChanged: (isGrid) {
                    if (!isSuccess) return;
                    _onViewModeChanged(isGrid);
                  },
                ),
                buildSpace(),
                if (state.getSavedState == RequestState.loading || state.getSavedState == RequestState.idle) ...[
                  _buildLoadingList(),
                ] else if (state.getSavedState == RequestState.error) ...[
                  _buildError(state.getSavedError),
                ] else ...[
                  state.getSaved.isEmpty
                      ? _buildEmpty()
                      : (_isGridView ? _buildGridView(state.getSaved) : _buildListView(state.getSaved)),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  void _onViewModeChanged(bool isGridView) {
    setState(() {
      _isGridView = isGridView;
    });
  }

  Widget _buildGridView(List<CategoryDetailsModel> items) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: .62,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FavoritesItme(
            favoritesItemModel: items[index],
            onLocationTap: _locationCallback(items[index]),
            isGridView: true,
          );
        },
      ),
    );
  }

  Widget _buildListView(List<CategoryDetailsModel> items) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverList.separated(
        separatorBuilder: (context, index) => 16.verticalSpace,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FavoritesItme(
            favoritesItemModel: items[index],
            onLocationTap: _locationCallback(items[index]),
            isGridView: false,
          );
        },
      ),
    );
  }

  Widget _buildLoadingList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverList.separated(
        separatorBuilder: (_, __) => 16.verticalSpace,
        itemCount: 6,
        itemBuilder: (_, __) => _FavoriteSkeletonItem(),
      ),
    );
  }

  Widget _buildError(String? message) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: ErrorView(errorMsg: message, onRetry: () => context.read<ProfileCubit>().getSaved()),
      ),
    );
  }

  Widget _buildEmpty() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: Text(LocaleKeys.noItems.tr(), style: Theme.of(context).textTheme.bodyMedium)),
    );
  }

  VoidCallback? _locationCallback(CategoryDetailsModel item) {
    final lat = item.location?.latitude;
    final lng = item.location?.longitude;
    if (lat == null || lng == null) return null;

    return () => getIt<LocationService>().openLocationInMaps(latitude: lat, longitude: lng);
  }
}

class _FavoriteSkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RedactedBox(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: ColorManager.borderColor),
          boxShadow: [
            BoxShadow(color: ColorManager.black.withValues(alpha: .1), blurRadius: 10, offset: const Offset(5, 3.5)),
          ],
        ),
        child: Row(
          children: [
            ShimmerBox(width: 90.w, height: 90.h, borderRadius: BorderRadius.circular(8.r)),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 160.w, height: 14.h),
                  8.verticalSpace,
                  ShimmerBox(width: 140.w, height: 12.h),
                  14.verticalSpace,
                  Row(
                    children: [
                      ShimmerBox(width: 32.w, height: 32.w, borderRadius: BorderRadius.circular(8.r)),
                      8.horizontalSpace,
                      ShimmerBox(width: 32.w, height: 32.w, borderRadius: BorderRadius.circular(8.r)),
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
