import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  final bool isLoading;
  const CategoryItem({super.key, required this.categoryModel, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(
        CategoryDetailsRoute(
          categoryName: categoryModel.name,
          categoryId: categoryModel.id,
          secondCategory: categoryModel.secondCategory,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isLoading ? ColorManager.lightGrey.withValues(alpha: .8) : ColorManager.primary,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: isLoading
              ? []
              : [
                  BoxShadow(
                    color: ColorManager.black.withValues(alpha: .25),
                    spreadRadius: -1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                  BoxShadow(
                    color: ColorManager.black.withValues(alpha: .25),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? ShimmerBox(
                    width: 40.w,
                    height: 40.w,
                    borderRadius: BorderRadius.circular(50),
                    color: ColorManager.lightGrey,
                  )
                : NetworkIcon(url: categoryModel.image, size: 34.w, color: ColorManager.white),

            SizedBox(height: 4.h),

            isLoading
                ? ShimmerBox(
                    width: 35.w,
                    height: 10.h,
                    borderRadius: BorderRadius.circular(4),
                    color: ColorManager.lightGrey,
                  )
                : BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Text(
                        context.read<HomeCubit>().getCategoryCountForCity(categoryModel).toString(),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white),
                      );
                    },
                  ),

            SizedBox(height: 4.h),

            isLoading
                ? ShimmerBox(
                    width: 50.w,
                    height: 10.h,
                    borderRadius: BorderRadius.circular(4),
                    color: ColorManager.lightGrey,
                  )
                : Text(
                    categoryModel.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
                  ),
          ],
        ),
      ),
    );
  }
}
