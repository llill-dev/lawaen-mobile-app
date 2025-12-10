import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/nearby/presentation/cubit/map_cubit.dart';
import 'package:lawaen/features/nearby/presentation/views/widgets/map_category_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'package:lawaen/app/core/widgets/primary_button.dart'; // <-- make sure path is correct

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
          minChildSize: 0.12,
          maxChildSize: 0.50,
          initialChildSize: 0.12,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: ColorManager.white,
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

        _buildSearchBar(context, cubit),

        SizedBox(height: 12.h),

        if (state.isSheetExpanded) _buildMainCategories(context, state),

        SizedBox(height: 8.h),

        if (state.selectedMainCategoryId != null && state.currentSubCategories.isNotEmpty)
          _buildSubCategories(context, state),

        if (state.showApplyButton) ...[
          SizedBox(height: 12.h),
          PrimaryButton(
            text: LocaleKeys.apply.tr(),
            isLoading: state.itemsState == RequestState.loading,
            onPressed: state.itemsState == RequestState.loading
                ? null
                : () {
                    _controller.animateTo(0.12, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
                    context.read<MapCubit>().applyCategory();
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
        width: 40.w,
        height: 4.h,
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, MapCubit cubit) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _searchController,
            hint: LocaleKeys.homeSearchBarHit.tr(),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SvgPicture.asset(IconManager.search),
            ),
            fillColor: Colors.white,
            horizontalContentPadding: 16,
            verticalContentPadding: 12,
            borderRadius: 16.0,
            onTap: () {
              if (!cubit.state.isSheetExpanded) {
                _expandSheetAnimated();
              }
            },
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                _controller.animateTo(0.12, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
                cubit.updateSearch(value);
              }
            },
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {
            final text = _searchController.text.trim();
            if (text.isNotEmpty) {
              _controller.animateTo(0.12, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
              cubit.updateSearch(text);
            }
          },
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: ColorManager.primary, borderRadius: BorderRadius.circular(16)),
            child: Icon(Icons.search, color: Colors.white, size: 26.sp),
          ),
        ),
      ],
    );
  }

  // ================================
  // MAIN CATEGORY LIST
  // ================================
  Widget _buildMainCategories(BuildContext context, MapState state) {
    if (state.categoriesState == RequestState.loading) {
      return SizedBox(
        height: 110.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) => MapCategoryItem(
            category: CategoryModel(id: '', name: '', image: '', description: null, secondCategory: const []),
            isSelected: false,
            isLoading: true,
            onTap: () {},
          ),
          separatorBuilder: (_, __) => 12.horizontalSpace,
          itemCount: 6,
        ),
      );
    }

    return SizedBox(
      height: 110.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.categories.length,
        itemBuilder: (_, index) {
          final cat = state.categories[index];
          final isSelected = state.selectedMainCategoryId == cat.id;

          return MapCategoryItem(
            category: cat,
            isSelected: isSelected,
            onTap: () => context.read<MapCubit>().selectMainCategory(isSelected ? null : cat.id),
          );
        },
      ),
    );
  }

  // ================================
  // SUB CATEGORY LIST
  // ================================
  Widget _buildSubCategories(BuildContext context, MapState state) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.currentSubCategories.length,
        itemBuilder: (_, index) {
          final sc = state.currentSubCategories[index];
          final isSelected = state.selectedSubCategoryId == sc.id;

          return MapSubCategoryItem(
            sub: sc,
            isSelected: isSelected,
            onTap: () => context.read<MapCubit>().selectSubCategory(isSelected ? null : sc.id),
          );
        },
      ),
    );
  }
}

class MapSubCategoryItem extends StatelessWidget {
  final SecondCategory sub;
  final bool isSelected;
  final VoidCallback onTap;

  const MapSubCategoryItem({super.key, required this.sub, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? ColorManager.primary : ColorManager.lightGrey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 95.w,
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (sub.image != null && sub.image!.isNotEmpty)
              NetworkIcon(url: sub.image!, size: 25.w, color: ColorManager.primary)
            else
              Image.asset(ImageManager.emptyPhoto, width: 35.w, height: 35.h),
            SizedBox(height: 6.h),
            Text(
              sub.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
