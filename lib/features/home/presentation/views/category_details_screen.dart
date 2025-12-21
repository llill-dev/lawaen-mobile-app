import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/app/core/widgets/custom_refresh_indcator.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/presentation/cubit/category_details_cubit/category_details_cubit.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/features/home/presentation/views/widgets/banners/banners_section.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_details/all_and_fillter_catergory_datails_row.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_details/category_details_app_bar.dart';

import '../../../../app/core/widgets/primary_back_button.dart';
import 'widgets/category_details/category_info_list.dart';

@RoutePage()
class CategoryDetailsScreen extends StatefulWidget {
  final String? categoryName;
  final String? categoryId;
  final List<SecondCategory>? secondCategory;

  const CategoryDetailsScreen({super.key, this.categoryId, this.secondCategory, this.categoryName});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  late CategoryDetailsCubit cubit;
  final ScrollController _scrollController = ScrollController();
  String? secondCatoryNames;

  @override
  void initState() {
    super.initState();
    cubit = getIt<CategoryDetailsCubit>();
    secondCatoryNames =
        widget.secondCategory
            ?.map((e) {
              if (e.name.isNotEmpty) {
                return e.name;
              }
            })
            .join(", ") ??
        "";

    final bool isGetAll = widget.categoryId == null;

    cubit.initCategoryDetails(mainCategoryId: widget.categoryId, isGetAll: isGetAll);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        cubit.loadMoreDebounced();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<CategoryDetailsCubit, CategoryDetailsState>(
          listenWhen: (prev, curr) => prev.globalError != curr.globalError && curr.globalError != null,
          listener: (context, state) {
            if (state.categoryDetailsState == RequestState.error) {
              alertDialog(
                message: state.globalError!,
                isError: true,
                context: context,
                onConfirm: () =>
                    cubit.initCategoryDetails(mainCategoryId: widget.categoryId, isGetAll: widget.categoryId == null),
                onCancel: () => cubit.clearGlobalError(),
              );
            }
          },
          child: SafeArea(
            child: CustomRefreshIndcator(
              onRefresh: () =>
                  cubit.initCategoryDetails(mainCategoryId: widget.categoryId, isGetAll: widget.categoryId == null),
              child: CustomScrollView(
                controller: _scrollController,
                clipBehavior: Clip.none,
                slivers: [
                  CategoryDetailsAppBar(
                    categoryId: widget.categoryId,
                    secondCategoryNames: secondCatoryNames,
                    formCategory: widget.categoryId != null,
                  ),

                  buildSpace(),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: PrimaryBackButton(withShadow: false).horizontalPadding(padding: 16.w),
                    ),
                  ),

                  buildSpace(),
                  if (widget.categoryName != null) ...[
                    SliverToBoxAdapter(
                      child: Text(
                        widget.categoryName!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ).horizontalPadding(padding: 16.w),
                    ),
                    buildSpace(),
                  ],

                  if (widget.secondCategory != null) ...[
                    AllAndFilterCategoryDetailsRow(secondCategory: widget.secondCategory!),
                    buildSpace(),
                  ],

                  if (context.read<HomeCubit>().state.otherBanners.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: BannersSection(
                        banners: context.read<HomeCubit>().state.otherBanners,
                      ).horizontalPadding(padding: 16.w),
                    ),
                    buildSpace(),
                  ],

                  CategoryInfoList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
