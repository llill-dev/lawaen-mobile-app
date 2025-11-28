import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/features/home/presentation/cubit/category_details_cubit.dart/category_details_cubit.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_details/category_details_item.dart';

class CategoryInfoList extends StatelessWidget {
  const CategoryInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
      builder: (context, state) {
        if (state.categoryDetailsState == RequestState.loading) {
          return const _CategoryDetailsSkeleton();
        }
        final items = state.categories;
        return SliverList.separated(
          separatorBuilder: (context, index) => 10.verticalSpace,
          itemBuilder: (context, index) {
            if (index == items.length) {
              return state.isLoadingMore
                  ? Padding(
                      padding: EdgeInsets.all(18),
                      child: Center(child: LoadingWidget()),
                    )
                  : SizedBox.shrink();
            }

            return CategoryDetailsItem(categoryDetailsModel: items[index]);
          },
          itemCount: items.length + 1,
        );
      },
    );
  }
}

class _CategoryDetailsSkeleton extends StatelessWidget {
  const _CategoryDetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              ShimmerBox(width: 50, height: 50, borderRadius: BorderRadius.circular(14)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: double.infinity, height: 14),
                    const SizedBox(height: 10),
                    ShimmerBox(width: 150, height: 12),
                  ],
                ),
              ),
            ],
          ),
        );
      }, childCount: 10),
    );
  }
}
