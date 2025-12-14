import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/core/widgets/grid_and_list_buttons_with_title.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/explore/data/models/user_preferences_model.dart';
import 'package:lawaen/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:lawaen/features/explore/presentation/views/widgets/user_preferences.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'recent_search.dart';

class ExploreHeaderSection extends StatefulWidget {
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
  State<ExploreHeaderSection> createState() => _ExploreHeaderSectionState();
}

class _ExploreHeaderSectionState extends State<ExploreHeaderSection> {
  Timer? _debounce;
  final TextEditingController _searchConttroller = TextEditingController();

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final trimmed = value.trim();
      if (trimmed.isEmpty) return;

      context.read<ExploreCubit>().getExplore(search: trimmed);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchConttroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recentSearch = context.watch<ExploreCubit>().state.recentSearches;

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
              isGridView: widget.isGridView,
              onViewModeChanged: widget.onViewModeChanged,
              title: LocaleKeys.explore.tr(),
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _searchConttroller,
                    hint: LocaleKeys.search_for_places_and_services.tr(),
                    fillColor: ColorManager.blackSwatch[3],
                    borderColor: ColorManager.blackSwatch[3],
                    verticalContentPadding: 14,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: SvgPicture.asset(IconManager.search),
                    ),
                    onFieldSubmitted: _onSearchChanged,
                  ),
                ),
                8.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    _onSearchChanged(_searchConttroller.text);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(color: ColorManager.primary, borderRadius: BorderRadius.circular(16)),
                    child: Icon(Icons.search, color: ColorManager.white, size: 26.sp),
                  ),
                ),
              ],
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
    if (widget.preferencesState == RequestState.success && widget.preferences.isEmpty) {
      return Text(LocaleKeys.thereAreNoPreferencesYet.tr(), style: Theme.of(context).textTheme.headlineSmall);
    }

    if (widget.preferences.isEmpty || widget.preferencesState == RequestState.error) {
      return const SizedBox.shrink();
    }

    return UserPreferences(
      preferences: widget.preferences,
      selectedCategoryId: context.watch<ExploreCubit>().state.selectedCategoryId,
      onSelect: (id) {
        context.read<ExploreCubit>().selectCategory(id);
      },
    );
  }

  Widget _buildRecentSearch(List<String> recentSearch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        RecentSearch(
          recentSearch: recentSearch,
          onTap: (value) {
            _searchConttroller.text = value;
            context.read<ExploreCubit>().getExplore(search: value, isLoadMore: false);
          },
        ),
      ],
    );
  }
}
