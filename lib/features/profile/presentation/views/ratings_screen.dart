import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/app_prefs.dart';
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
import 'package:lawaen/features/profile/presentation/views/widget/ratings/ratings_itme.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class RatingsScreen extends StatefulWidget {
  const RatingsScreen({super.key});

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  bool _isGridView = false;
  late final String? _userName;

  @override
  void initState() {
    super.initState();
    _userName = getIt<AppPreferences>().getUserInfo()?.name;
    context.read<ProfileCubit>().getRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final isSuccess = state.getRatedState == RequestState.success;

            return CustomScrollView(
              clipBehavior: Clip.none,
              slivers: [
                CustomProfileHeaderSections(
                  tilte: LocaleKeys.reatings.tr(),
                  withBackButton: true,
                  isGridView: _isGridView,
                  showSearch: false,
                  onViewModeChanged: (isGrid) {
                    if (!isSuccess) return;
                    _onViewModeChanged(isGrid);
                  },
                ),
                buildSpace(),
                if (state.getRatedState == RequestState.loading || state.getRatedState == RequestState.idle) ...[
                  _buildLoadingList(),
                ] else if (state.getRatedState == RequestState.error) ...[
                  _buildError(state.getRatedError),
                ] else ...[
                  state.getRated.isEmpty
                      ? _buildEmpty()
                      : (_isGridView ? _buildGridView(state.getRated) : _buildListView(state.getRated)),
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
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .67,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => RatingsItme(
            isGridView: true,
            ratingItemModel: items[index],
            userName: _userName,
            onLocationTap: _locationCallback(items[index]),
          ),
          childCount: items.length,
        ),
      ),
    );
  }

  Widget _buildListView(List<CategoryDetailsModel> items) {
    return SliverList.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => RatingsItme(
        ratingItemModel: items[index],
        userName: _userName,
        onLocationTap: _locationCallback(items[index]),
      ),
    );
  }

  Widget _buildLoadingList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverList.separated(
        separatorBuilder: (_, __) => 16.verticalSpace,
        itemCount: 6,
        itemBuilder: (_, __) => _RatingSkeletonItem(),
      ),
    );
  }

  Widget _buildError(String? message) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: ErrorView(errorMsg: message, onRetry: () => context.read<ProfileCubit>().getRated()),
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

class _RatingSkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RedactedBox(
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: ColorManager.borderColor),
          boxShadow: [
            BoxShadow(color: ColorManager.black.withValues(alpha: .1), blurRadius: 10, offset: const Offset(5, 3.5)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(width: 90.w, height: 90.h, borderRadius: BorderRadius.circular(8.r)),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 120.w, height: 14.h),
                  10.verticalSpace,
                  ShimmerBox(width: 160.w, height: 12.h),
                  8.verticalSpace,
                  ShimmerBox(width: 120.w, height: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
