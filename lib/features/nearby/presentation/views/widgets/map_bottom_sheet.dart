import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/nearby/presentation/cubit/map_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';

class MapBottomSheet extends StatefulWidget {
  const MapBottomSheet({super.key});

  @override
  State<MapBottomSheet> createState() => _MapBottomSheetState();
}

class _MapBottomSheetState extends State<MapBottomSheet> {
  // final DraggableScrollableController _controller = DraggableScrollableController();
  // bool _hasExpandedOnce = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MapCubit>().expandSheet(true);

    // _controller.addListener(() {
    //   final cubit = context.read<MapCubit>();
    //   final isExpanded = _controller.size > 0.20;
    //
    //   if (isExpanded != cubit.state.isSheetExpanded) {
    //     cubit.expandSheet(isExpanded);
    //   }
    //
    //   if (isExpanded && !_hasExpandedOnce) {
    //     _hasExpandedOnce = true;
    //     cubit.expandSheet(true);
    //   }
    // });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: _buildContent(context, state),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, MapState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // _buildDragHandle(),
        // 12.verticalSpace,

        // // If you want it visible, uncomment:
        // _buildSearchBar(context, cubit),

        // 24.verticalSpace,
        // InkWell(
        //   onTap: () {
        //     if (!cubit.state.isSheetExpanded) {
        //       _expandSheetAnimated();
        //     }
        //   },
        //   child: Column(
        //     children: [
        //       Text(
        //         LocaleKeys.mapBottomSheetTitle.tr(),
        //         style: Theme.of(context).textTheme.displayMedium?.copyWith(color: ColorManager.black),
        //       ),
        //       8.verticalSpace,
        //       Text(
        //         LocaleKeys.mapBottomSheetDescription.tr(),
        //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white),
        //       ),
        //     ],
        //   ),
        // ),
        Column(
          children: [
            Text(
              LocaleKeys.mapBottomSheetTitle.tr(),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: ColorManager.white),
            ),
            8.verticalSpace,
            Text(
              LocaleKeys.mapBottomSheetDescription.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white),
            ),
          ],
        ),

        12.verticalSpace,
        SizedBox(height: 12.h),

        Text(
          LocaleKeys.mainCategory.tr(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
        ),
        SizedBox(height: 8.h),

        _buildMainCategories(context, state),
        SizedBox(height: 8.h),

        if (state.selectedMainCategoryId != null && state.currentSubCategories.isNotEmpty) ...[
          Text(
            LocaleKeys.subCategory.tr(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
          ),
          SizedBox(height: 8.h),
          _buildSubCategories(context, state),
          SizedBox(height: 8.h),
        ],

        if (state.showApplyButton) ...[
          SizedBox(height: 12.h),
          PrimaryButton(
            isLight: true,
            backgroundColor: ColorManager.white,
            borederColor: ColorManager.white,
            text: LocaleKeys.apply.tr(),
            isLoading: state.itemsState == RequestState.loading,
            onPressed: state.itemsState == RequestState.loading
                ? null
                : () {
                    final cubit = context.read<MapCubit>();

                    cubit.applyCategory();
                    cubit.resetCategoryFilter();

                    context.router.pop();
                  },
          ),
        ],

        SizedBox(height: 8.h),
      ],
    );
  }

  // Widget _buildSearchBar(BuildContext context, MapCubit cubit) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: CustomTextField(
  //           controller: _searchController,
  //           readOnly: true,
  //           hint: LocaleKeys.homeSearchBarHit.tr(),
  //           prefixIcon: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 12.w),
  //             child: SvgPicture.asset(IconManager.search),
  //           ),
  //           fillColor: ColorManager.white,
  //           borderColor: ColorManager.white,
  //           horizontalContentPadding: 16,
  //           verticalContentPadding: 12,
  //           borderRadius: 16.0,
  //           onTap: () {
  //             if (!cubit.state.isSheetExpanded) {
  //               _expandSheetAnimated();
  //             }
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildMainCategories(BuildContext context, MapState state) {
    if (state.categoriesState == RequestState.loading) {
      return _buildDropdownLoading();
    }

    final categoryLabels = {for (final cat in state.categories) cat.id: cat.name};
    final categoryIds = categoryLabels.keys.toList();
    final selectedMain = categoryIds.contains(state.selectedMainCategoryId) ? state.selectedMainCategoryId : null;

    if (selectedMain == null && state.selectedMainCategoryId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.read<MapCubit>().selectMainCategory(null));
    }

    return SizedBox(
      width: double.infinity,
      child: DropDownItem(
        withTitle: false,
        fillColor: ColorManager.white,
        title: LocaleKeys.mainCategory.tr(),
        hit: LocaleKeys.mainCategory.tr(),
        items: categoryIds,
        initialValue: selectedMain,
        itemLabelBuilder: (id) => categoryLabels[id] ?? id,
        onChanged: (value) {
          final cubit = context.read<MapCubit>();
          if (value == state.selectedMainCategoryId) {
            cubit.selectMainCategory(null);
          } else {
            cubit.selectMainCategory(value);
          }
        },
      ),
    );
  }

  Widget _buildDropdownLoading() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.lightGrey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: SizedBox(
          height: 22.w,
          width: 22.w,
          child: CircularProgressIndicator(strokeWidth: 2.5, color: ColorManager.primary),
        ),
      ),
    );
  }

  Widget _buildSubCategories(BuildContext context, MapState state) {
    final subCategoryLabels = {for (final sub in state.currentSubCategories) sub.id: sub.name};
    final subCategoryIds = subCategoryLabels.keys.toList();
    final selectedSub = subCategoryIds.contains(state.selectedSubCategoryId) ? state.selectedSubCategoryId : null;

    if (selectedSub == null && state.selectedSubCategoryId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.read<MapCubit>().selectSubCategory(null));
    }

    return SizedBox(
      width: double.infinity,
      child: DropDownItem(
        withTitle: false,
        fillColor: ColorManager.white,
        title: LocaleKeys.subCategory.tr(),
        hit: LocaleKeys.subCategory.tr(),
        items: subCategoryIds,
        initialValue: selectedSub,
        itemLabelBuilder: (id) => subCategoryLabels[id] ?? id,
        onChanged: (value) {
          final cubit = context.read<MapCubit>();
          if (value == state.selectedSubCategoryId) {
            cubit.selectSubCategory(null);
          } else {
            cubit.selectSubCategory(value);
          }
        },
      ),
    );
  }
}
