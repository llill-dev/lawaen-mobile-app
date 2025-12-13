import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/core/widgets/shimmer_loading_widget.dart';
import 'package:lawaen/features/home/presentation/cubit/mune_cubit/mune_cubit.dart';
import 'package:lawaen/features/home/presentation/params/get_menu_params.dart';
import 'widgets/mune/mune_item.dart';
import 'widgets/mune/opening_closing_time.dart';

@RoutePage()
class MuneScreen extends StatefulWidget {
  final String secondId;
  final String itemId;
  final String? openColseTimes;
  const MuneScreen({super.key, required this.secondId, required this.itemId, this.openColseTimes});

  @override
  State<MuneScreen> createState() => _MuneScreenState();
}

class _MuneScreenState extends State<MuneScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final hasData = context.read<MuneCubit>().state.mune?.categories.isNotEmpty ?? false;
      if (!hasData) {
        context.read<MuneCubit>().getMune(GetMenuParams(categoryId: widget.secondId, itemId: widget.itemId));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocConsumer<MuneCubit, MuneState>(
        listener: (context, state) {
          if (state.muneError != null && state.muneState == RequestState.error) {
            alertDialog(
              context: context,
              message: state.muneError!,
              onConfirm: () {
                context.read<MuneCubit>().getMune(GetMenuParams(categoryId: widget.secondId, itemId: widget.itemId));
              },
            );
          }
        },
        builder: (context, state) {
          final categories = state.mune?.categories ?? [];

          return SafeArea(
            child: CustomScrollView(
              clipBehavior: Clip.none,
              slivers: [
                SliverToBoxAdapter(child: PrimaryBackButton().horizontalPadding(padding: 16.w)),
                if (state.muneState == RequestState.loading)
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) => _MuneItemSkeleton(), childCount: 3),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final category = categories[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (category.items.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8.h),
                              child: Text(category.title ?? "", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ...category.items.map(
                            (item) => MuneItemWidget(item: item, muneCategoryTitle: category.title ?? ""),
                          ),
                        ],
                      );
                    }, childCount: categories.length),
                  ),
                if (widget.openColseTimes != null) OpeningClosingTime(openColseTimes: widget.openColseTimes!),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MuneItemSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: .1),
            spreadRadius: -1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoadingWidget(height: 160.h, width: double.infinity, borderRadius: BorderRadius.circular(14)),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoadingWidget(height: 16.h, width: 140.w),
                12.verticalSpace,
                ShimmerLoadingWidget(height: 14.h, width: double.infinity),
                8.verticalSpace,
                ShimmerLoadingWidget(height: 14.h, width: 220.w),
                16.verticalSpace,
                ShimmerLoadingWidget(height: 24.h, width: 80.w, borderRadius: BorderRadius.circular(10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
