import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import 'widgets/explore_header_section.dart';
import 'widgets/explore_item.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const int _itemsCount = 8;

  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            ExploreHeaderSection(isGridView: _isGridView, onViewModeChanged: _onViewModeChanged),
            buildSpace(),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconManager.trending,
                    colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
                  ),
                  3.horizontalSpace,
                  Text(
                    'Most Popular',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.primary),
                  ),
                ],
              ).horizontalPadding(padding: 16.w),
            ),
            buildSpace(),
            if (_isGridView) _buildGridView() else _buildListView(),
          ],
        ),
      ),
    );
  }

  void _onViewModeChanged(bool isGridView) {
    if (_isGridView == isGridView) return;
    setState(() {
      _isGridView = isGridView;
    });
  }

  Widget _buildGridView() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => ExploreItem(isGridView: true),
          childCount: _itemsCount,
        ),
      ),
    );
  }

  Widget _buildListView() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: SliverList.separated(
        itemCount: _itemsCount,
        separatorBuilder: (context, index) => 12.verticalSpace,
        itemBuilder: (context, index) => ExploreItem(isGridView: false),
      ),
    );
  }
}
