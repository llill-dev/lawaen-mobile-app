import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/presentation/cubit/category_details_cubit.dart/category_details_cubit.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar.dart';

import '../../../../app/core/widgets/primary_back_button.dart';
import '../../../../app/resources/color_manager.dart';
import 'widgets/category_details/category_info_list.dart';
import 'widgets/category_details/filter_category_info.dart';

@RoutePage()
class CategoryDetailsScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  final List<SecondCategory> secondCategory;
  const CategoryDetailsScreen({
    super.key,
    required this.categoryId,
    required this.secondCategory,
    required this.categoryName,
  });

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  late CategoryDetailsCubit cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit = getIt<CategoryDetailsCubit>();
    cubit.initCategoryDetails(widget.categoryId, null);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        cubit.loadMore(widget.categoryId, null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            clipBehavior: Clip.none,
            slivers: [
              SliverToBoxAdapter(child: HomeAppBar()),

              buildSpace(),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PrimaryBackButton(withShadow: true, width: 75.w).horizontalPadding(padding: 16.w),
                ),
              ),

              buildSpace(),
              SliverToBoxAdapter(
                child: Text(
                  widget.categoryName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).horizontalPadding(padding: 16.w),
              ),

              buildSpace(),
              AllAndFilterRow(secondCategory: widget.secondCategory),

              buildSpace(),
              CategoryInfoList(),
            ],
          ),
        ),
      ),
    );
  }
}

class AllAndFilterRow extends StatelessWidget {
  final List<SecondCategory> secondCategory;
  const AllAndFilterRow({super.key, required this.secondCategory});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(color: ColorManager.primary, borderRadius: BorderRadius.circular(10.r)),
            child: Text("All", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white)),
          ),
          8.horizontalSpace,
          GestureDetector(
            onTap: () => _showFilterBottomSheet(context, secondCategory.map((e) => e.name).toList()),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(10.r)),
              child: Row(
                children: [
                  SvgPicture.asset(IconManager.filter),
                  6.horizontalSpace,
                  Text("filter", style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
            ),
          ),
        ],
      ).horizontalPadding(padding: 16.w),
    );
  }

  void _showFilterBottomSheet(BuildContext context, List<String> subCategories) {
    final ValueNotifier<Set<String>> selected = ValueNotifier<Set<String>>({});
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) {
        return FilterCategoryInfo(selected: selected, subCategories: subCategories);
      },
    );
  }
}
