import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/custom_text_field.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/nearby/presentation/cubit/map_cubit.dart';
import 'package:lawaen/features/nearby/presentation/views/widgets/map_category_item.dart';

import 'package:lawaen/generated/locale_keys.g.dart';

class MapBottomSheet extends StatefulWidget {
  const MapBottomSheet({super.key});

  @override
  State<MapBottomSheet> createState() => _MapBottomSheetState();
}

class _MapBottomSheetState extends State<MapBottomSheet> {
  final DraggableScrollableController _controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();

    // Listen to sheet size changes to know when it's "expanded"
    _controller.addListener(() {
      final cubit = context.read<MapCubit>();
      final isExpanded = _controller.size > 0.20;
      if (isExpanded != cubit.state.isSheetExpanded) {
        cubit.expandSheet(isExpanded);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      minChildSize: 0.12, // collapsed
      maxChildSize: 0.35, // expanded
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
            child: _buildContent(context),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    final cubit = context.read<MapCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Container(
          width: 40.w,
          height: 4.h,
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(12)),
        ),

        // SEARCH BAR
        CustomTextField(
          hint: LocaleKeys.homeSearchBarHit.tr(),
          hitStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.grey),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SvgPicture.asset(IconManager.search),
          ),
          fillColor: Colors.white,
          horizontalContentPadding: 16,
          verticalContentPadding: 12,
          borderRadius: 16.0,
          onFieldSubmitted: (value) {
            if (value.isNotEmpty) {
              cubit.updateSearch(value);
            }
          },
        ),

        SizedBox(height: 12.h),

        // CATEGORIES (only when expanded)
        BlocBuilder<MapCubit, MapState>(
          buildWhen: (prev, curr) =>
              prev.categories != curr.categories ||
              prev.selectedCategoryId != curr.selectedCategoryId ||
              prev.categoriesState != curr.categoriesState ||
              prev.isSheetExpanded != curr.isSheetExpanded,
          builder: (context, state) {
            if (!state.isSheetExpanded) {
              // When sheet is collapsed, we only show the search bar
              return const SizedBox.shrink();
            }

            if (state.categoriesState == RequestState.loading) {
              // Skeletons while loading categories
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

            if (state.categories.isEmpty) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(LocaleKeys.notFound.tr(), style: Theme.of(context).textTheme.bodyMedium),
              );
            }

            return SizedBox(
              height: 110.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (_, index) {
                  final cat = state.categories[index];
                  final isSelected = state.selectedCategoryId == cat.id;

                  return MapCategoryItem(
                    category: cat,
                    isSelected: isSelected,
                    onTap: () => cubit.selectCategory(isSelected ? null : cat.id),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
