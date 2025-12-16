import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/presentation/cubit/category_details_cubit/category_details_cubit.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_details/filter_category_info.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class AllAndFilterCategoryDetailsRow extends StatelessWidget {
  final List<SecondCategory> secondCategory;
  const AllAndFilterCategoryDetailsRow({super.key, required this.secondCategory});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
        buildWhen: (prev, curr) => prev.selectedSecondCategoryId != curr.selectedSecondCategoryId,
        builder: (context, state) {
          final bool isAllSelected = state.selectedSecondCategoryId == null;

          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<CategoryDetailsCubit>().selectSecondCategory(null);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isAllSelected ? ColorManager.primary : ColorManager.lightGrey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    LocaleKeys.all.tr(),
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: isAllSelected ? ColorManager.white : ColorManager.black),
                  ),
                ),
              ),
              8.horizontalSpace,
              GestureDetector(
                onTap: () async {
                  final selectedId = await _showFilterBottomSheet(
                    context,
                    secondCategory,
                    state.selectedSecondCategoryId,
                  );

                  if (selectedId != null && context.mounted) {
                    context.read<CategoryDetailsCubit>().selectSecondCategory(selectedId);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    children: [
                      SvgPicture.asset(IconManager.filter),
                      6.horizontalSpace,
                      Text(LocaleKeys.filter.tr(), style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),
              ),
            ],
          ).horizontalPadding(padding: 16.w);
        },
      ),
    );
  }

  Future<String?> _showFilterBottomSheet(
    BuildContext context,
    List<SecondCategory> subCategories,
    String? currentSelectedId,
  ) {
    return showModalBottomSheet<String?>(
      context: context,
      showDragHandle: true,
      backgroundColor: ColorManager.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) {
        return FilterCategoryInfo(subCategories: subCategories, initialSelectedId: currentSelectedId);
      },
    );
  }
}
