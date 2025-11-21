import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/features/profile/presentation/views/widget/custom_profile_header_section.dart';
import 'package:lawaen/features/profile/presentation/views/widget/ratings/ratings_itme.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class RatingsScreen extends StatefulWidget {
  const RatingsScreen({super.key});

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  bool _isGridView = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            CustomProfileHeaderSections(
              tilte: LocaleKeys.reatings.tr(),
              withBackButton: true,
              isGridView: _isGridView,
              onViewModeChanged: _onViewModeChanged,
            ),
            buildSpace(),
            if (_isGridView) _buildGridView() else _buildListView(),
          ],
        ),
      ),
    );
  }

  void _onViewModeChanged(bool isGridView) {
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
          childAspectRatio: .85,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => RatingsItme(
            isGridView: true,
            ratingItemModel: RatingItemModel(
              title: 'ayham kefo ',
              description:
                  'Laborum quasi distinctio est et. Sequi omnis molestiae. Officia occaecati voluptatem accusantium. Et corrupti saepe quam.',
              imageUrl: ImageManager.ratings,
            ),
          ),
          childCount: 8,
        ),
      ),
    );
  }

  Widget _buildListView() {
    return SliverList.builder(
      itemBuilder: (context, index) => RatingsItme(
        ratingItemModel: RatingItemModel(
          title: 'USER',
          description:
              'Laborum quasi distinctio est et. Sequi omnis molestiae. Officia occaecati voluptatem accusantium. Et corrupti saepe quam.',
          imageUrl: ImageManager.ratings,
        ),
      ),
    );
  }
}
