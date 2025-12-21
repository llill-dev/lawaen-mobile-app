import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/features/home/presentation/views/widgets/banners/banners_section.dart';

import 'banner_item_widget.dart';

class HomeBannersSection extends StatelessWidget {
  final bool isFirstHalf;
  final double? height;

  const HomeBannersSection({super.key, required this.isFirstHalf, this.height});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.bannersState == RequestState.loading) {
          return SliverToBoxAdapter(
            child: BannerItemSkeleton(height: height ?? 80).horizontalPadding(padding: 16.w),
          );
        }

        if (state.bannersState == RequestState.error || state.homeBanners.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        final homeBanners = state.homeBanners;
        final mid = (homeBanners.length / 2).ceil();

        final banners = isFirstHalf ? homeBanners.sublist(0, mid) : homeBanners.sublist(mid);

        if (banners.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverToBoxAdapter(
          child: BannersSection(banners: banners, height: height ?? 80).horizontalPadding(padding: 16.w),
        );
      },
    );
  }
}
