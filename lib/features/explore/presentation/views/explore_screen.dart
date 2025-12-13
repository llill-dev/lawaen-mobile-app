import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/app/core/widgets/empty_view.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'widgets/explore_header_section.dart';
import 'widgets/explore_item.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with AutomaticKeepAliveClientMixin {
  bool _isGridView = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ExploreCubit>();
    if (cubit.state.exploreItems.isEmpty && cubit.state.exploreState != RequestState.loading) {
      cubit.getExplore();
    }
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final cubit = context.read<ExploreCubit>();
      if (cubit.state.exploreState == RequestState.loading) return;
      cubit.getExplore(isLoadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ExploreCubit, ExploreState>(
          listener: (context, state) {
            if (state.exploreState == RequestState.error && state.exploreError != null) {
              alertDialog(
                context: context,
                message: state.exploreError!,
                onConfirm: () => context.read<ExploreCubit>().getExplore(),
              );
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              controller: _scrollController,
              clipBehavior: Clip.none,
              slivers: [
                ExploreHeaderSection(isGridView: _isGridView, onViewModeChanged: _onViewModeChanged),
                buildSpace(),
                _buildTitle(context),
                buildSpace(),
                ..._buildContent(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, ExploreState state) {
    if (state.exploreState == RequestState.loading && state.exploreItems.isEmpty && !state.isLoadMore) {
      return [const _ExploreGridSkeleton()];
    }

    final items = state.exploreItems;
    if (items.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: EmptyView(message: LocaleKeys.notFound.tr(), icon: IconManager.emptySearch),
          ),
        ),
      ];
    }

    return [
      _isGridView ? _buildGridView(items) : _buildListView(items),
      SliverToBoxAdapter(
        child: state.isLoadMore
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(child: LoadingWidget()),
              )
            : const SizedBox.shrink(),
      ),
    ];
  }

  SliverToBoxAdapter _buildTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          SvgPicture.asset(IconManager.trending, colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn)),
          3.horizontalSpace,
          Text(
            LocaleKeys.mostPopular.tr(),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.primary),
          ),
        ],
      ).horizontalPadding(padding: 16.w),
    );
  }

  void _onViewModeChanged(bool isGridView) {
    if (_isGridView == isGridView) return;
    setState(() {
      _isGridView = isGridView;
    });
  }

  Widget _buildGridView(List<CategoryDetailsModel> items) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => ExploreItem(item: items[index], isGridView: true),
          childCount: items.length,
        ),
      ),
    );
  }

  Widget _buildListView(List<CategoryDetailsModel> items) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: SliverList.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => 12.verticalSpace,
        itemBuilder: (context, index) => ExploreItem(item: items[index], isGridView: false),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ExploreGridSkeleton extends StatelessWidget {
  const _ExploreGridSkeleton();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => RedactedBox(
            child: Container(
              decoration: BoxDecoration(color: ColorManager.white, borderRadius: BorderRadius.circular(14)),
              height: 180.h,
            ),
          ),
          childCount: 6,
        ),
      ),
    );
  }
}
