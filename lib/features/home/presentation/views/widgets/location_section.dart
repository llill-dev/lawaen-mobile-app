import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (p, c) => p.citiesState != c.citiesState,
        builder: (context, state) {
          if (state.citiesState == RequestState.loading) {
            return _buildSkeletonLoader();
          }

          if (state.citiesState == RequestState.error) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              height: 0.12.sh,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.cities.length,
                separatorBuilder: (_, _) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  final city = state.cities[index];
                  return Column(
                    children: [
                      Expanded(
                        child: AspectRatio(aspectRatio: 1, child: CachedNetworkImage(imageUrl: city.image)),
                      ),
                      8.verticalSpace,
                      Text(city.name, style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: 0.12.sh,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          separatorBuilder: (_, _) => SizedBox(width: 16.w),
          itemBuilder: (_, _) => const _CitySkeleton(),
        ),
      ),
    );
  }
}

class _CitySkeleton extends StatelessWidget {
  const _CitySkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(shape: BoxShape.circle, color: ColorManager.lightGrey),
          ),
          8.verticalSpace,
          Container(
            width: 60.w,
            height: 12.h,
            decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(8.r)),
          ),
        ],
      ),
    );
  }
}
