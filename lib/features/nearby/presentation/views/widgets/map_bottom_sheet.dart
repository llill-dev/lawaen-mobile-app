import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
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
  final DraggableScrollableController _controller = DraggableScrollableController();
  bool _hasExpandedOnce = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final cubit = context.read<MapCubit>();
      final isExpanded = _controller.size > 0.20;

      if (isExpanded != cubit.state.isSheetExpanded) {
        cubit.expandSheet(isExpanded);
      }

      if (isExpanded && !_hasExpandedOnce) {
        _hasExpandedOnce = true;
        cubit.expandSheet(true);
      }
    });
  }

  void _expandSheetAnimated() {
    _controller.animateTo(0.35, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return DraggableScrollableSheet(
          controller: _controller,
          minChildSize: 0.17,
          maxChildSize: 0.50,
          initialChildSize: 0.17,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withOpacity(0.15),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: _buildContent(context, state),
              ),
            );
          },
        );
      },
    );
  }

  // ======================================================
  // MAIN CONTENT
  // ======================================================
  Widget _buildContent(BuildContext context, MapState state) {
    final cubit = context.read<MapCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDragHandle(),
        InkWell(
          onTap: () {
            if (!cubit.state.isSheetExpanded) {
              _expandSheetAnimated();
            }
          },
          child: Column(
            children: [
              Text(
                LocaleKeys.mapBottomSheetTitle.tr(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: ColorManager.black),
              ),
              8.verticalSpace,
              Text(
                LocaleKeys.mapBottomSheetDescription.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white),
              ),
            ],
          ),
        ),
        12.verticalSpace,

        // _buildSearchBar(context, cubit),
        // SizedBox(height: 12.h),
        if (state.isSheetExpanded) ...[
          Text(
            LocaleKeys.mainCategory.tr(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.black),
          ),
          SizedBox(height: 8.h),
          _buildMainCategories(context, state),
          SizedBox(height: 8.h),
        ],

        if (state.selectedMainCategoryId != null && state.currentSubCategories.isNotEmpty) ...[
          Text(
            LocaleKeys.subCategory.tr(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.black),
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
                    _controller.animateTo(0.12, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
                    context.read<MapCubit>().applyCategory();
                    context.read<MapCubit>().selectMainCategory(null);
                    context.read<MapCubit>().selectSubCategory(null);
                  },
          ),
        ],

        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 60.w,
        height: 4.h,
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(color: ColorManager.white, borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // Widget _buildSearchBar(BuildContext context, MapCubit cubit) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: CustomTextField(
  //           controller: _searchController,
  //           hint: LocaleKeys.homeSearchBarHit.tr(),
  //           prefixIcon: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 12.w),
  //             child: SvgPicture.asset(IconManager.search),
  //           ),
  //           fillColor: ColorManager.lightGrey,
  //           borderColor: ColorManager.lightGrey,
  //           horizontalContentPadding: 16,
  //           verticalContentPadding: 12,
  //           borderRadius: 16.0,
  //           onTap: () {
  //             if (!cubit.state.isSheetExpanded) {
  //               _expandSheetAnimated();
  //             }
  //           },
  //           onFieldSubmitted: (value) {
  //             if (value.isNotEmpty) {
  //               _controller.animateTo(0.12, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  //               cubit.updateSearch(value);
  //             }
  //           },
  //         ),
  //       ),
  //       SizedBox(width: 10.w),
  //       GestureDetector(
  //         onTap: () {
  //           final text = _searchController.text.trim();
  //           if (text.isNotEmpty) {
  //             _controller.animateTo(0.12, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  //             cubit.updateSearch(text);
  //           }
  //         },
  //         child: Container(
  //           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
  //           decoration: BoxDecoration(color: ColorManager.primary, borderRadius: BorderRadius.circular(16)),
  //           child: Icon(Icons.search, color: ColorManager.white, size: 26.sp),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // ================================
  // MAIN CATEGORY LIST
  // ================================
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

  // ================================
  // SUB CATEGORY LIST
  // ================================
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
