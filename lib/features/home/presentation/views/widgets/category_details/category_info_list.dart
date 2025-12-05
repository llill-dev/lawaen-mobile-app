import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/features/home/presentation/cubit/category_details_cubit/category_details_cubit.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_details/category_details_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class CategoryInfoList extends StatelessWidget {
  const CategoryInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
      builder: (context, state) {
        if (state.categoryDetailsState == RequestState.loading) {
          return const _CategoryDetailsSkeleton();
        }
        if (state.categories.isEmpty && !state.isLoadingMore) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                LocaleKeys.notFound.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          );
        }
        final items = state.categories;
        return SliverList.separated(
          separatorBuilder: (context, index) {
            if (items[index].name == null &&
                items[index].address == null &&
                (items[index].image == null || items[index].image!.isEmpty)) {
              return SizedBox.shrink();
            }
            return 10.verticalSpace;
          },
          itemBuilder: (context, index) {
            if (index == items.length) {
              return state.isLoadingMore
                  ? Padding(
                      padding: EdgeInsets.all(18),
                      child: Center(child: LoadingWidget()),
                    )
                  : SizedBox.shrink();
            }
            if (items[index].name == null &&
                items[index].address == null &&
                (items[index].image == null || items[index].image!.isEmpty)) {
              return SizedBox.shrink();
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
