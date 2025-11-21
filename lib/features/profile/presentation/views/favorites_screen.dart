import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/features/profile/presentation/views/widget/custom_profile_header_section.dart';
import 'package:lawaen/features/profile/presentation/views/widget/favorites/favorites_itme.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isGridView = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            CustomProfileHeaderSections(
              tilte: LocaleKeys.favorites.tr(),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: .58,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return FavoritesItme(
            favoritesItemModel: FavoritesItemModel(
              title: "Apartment for Rent",
              details: "${index + 1} room",
              imageUrl: ImageManager.place,
              isClosed: index % 2 == 0,
            ),
            isGridView: true,
          );
        },
      ),
    );
  }

  Widget _buildListView() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverList.separated(
        separatorBuilder: (context, index) => 16.verticalSpace,
        itemCount: 4,
        itemBuilder: (context, index) {
          return FavoritesItme(
            favoritesItemModel: FavoritesItemModel(
              title: "Apartment for Rent",
              details: "${index + 1} room",
              imageUrl: ImageManager.place,
              isClosed: index % 2 == 0,
            ),
            isGridView: false,
          );
        },
      ),
    );
  }
}
