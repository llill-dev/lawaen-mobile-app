import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'category_item.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (p, c) => p.categoriesState != c.categoriesState,
        builder: (context, state) {
          final isLoading = state.categoriesState == RequestState.loading;

          if (state.categoriesState == RequestState.error) {
            return const SizedBox.shrink();
          }

          return Skeletonizer(
            enabled: isLoading,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: .8,
                ),
                itemCount: isLoading ? 6 : state.categories.length.clamp(0, 6),
                itemBuilder: (_, index) {
                  if (isLoading) {
                    return CategoryItem(
                      categoryModel: CategoryModel(description: "", id: "", image: "", name: "", secondCategory: []),
                      isLoading: true,
                    );
                  }
                  final item = state.categories[index];
                  return CategoryItem(categoryModel: item);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
