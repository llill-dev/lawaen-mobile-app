import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/core/widgets/grid_and_list_buttons_with_title.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/explore/data/models/user_preferences_model.dart';
import 'package:lawaen/features/explore/presentation/views/widgets/user_preferences.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'recent_search.dart';

class ExploreHeaderSection extends StatelessWidget {
  const ExploreHeaderSection({
    super.key,
    required this.isGridView,
    required this.onViewModeChanged,
    required this.preferences,
    required this.preferencesState,
  });

  final bool isGridView;
  final ValueChanged<bool> onViewModeChanged;
  final List<UserPreferencesModel> preferences;
  final RequestState preferencesState;

  @override
  Widget build(BuildContext context) {
    final List<String> recentSearch = [];
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 0.1),
              offset: const Offset(0, 1),
              spreadRadius: -1,
              blurRadius: 2,
            ),
            BoxShadow(color: ColorManager.black.withValues(alpha: 0.1), offset: const Offset(0, 1), blurRadius: 3),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridAndListButtonsWithTitle(
              isGridView: isGridView,
              onViewModeChanged: onViewModeChanged,
              title: LocaleKeys.explore.tr(),
            ),
            16.verticalSpace,
            CustomTextField(
              hint: LocaleKeys.search_for_places_and_services.tr(),
              fillColor: ColorManager.blackSwatch[3],
              borderColor: ColorManager.blackSwatch[3],
              verticalContentPadding: 14,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: SvgPicture.asset(IconManager.search),
              ),
            ),
            16.verticalSpace,
            Text(
              LocaleKeys.userPreferences.tr(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.black),
            ),
            8.verticalSpace,
            _buildPreferences(context),
            16.verticalSpace,
            if (recentSearch.isNotEmpty) _buildRecentSearch(recentSearch),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferences(BuildContext context) {
    final preferenceNames = preferences.map((e) => e.name).toList();

    if (preferencesState == RequestState.success && preferenceNames.isEmpty) {
      return Text(LocaleKeys.thereAreNoPreferencesYet.tr(), style: Theme.of(context).textTheme.headlineSmall);
    }

    if (preferenceNames.isEmpty || preferencesState == RequestState.error) {
      return const SizedBox.shrink();
    }

    return UserPreferences(userPreferences: preferenceNames);
  }

  Widget _buildRecentSearch(List<String> recentSearch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        RecentSearch(recentSearch: recentSearch),
      ],
    );
  }
}
