import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LocationSection extends StatefulWidget {
  const LocationSection({super.key});

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  final ScrollController _scrollController = ScrollController();

  bool _canScrollBack = false;
  bool _canScrollForward = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;

    setState(() {
      _canScrollBack = offset > 0;
      _canScrollForward = offset < maxScroll;
    });
  }

  void _scrollBy(double value) {
    _scrollController.animateTo(
      _scrollController.offset + value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (p, c) => p.citiesState != c.citiesState || p.currentCity != c.currentCity,
        builder: (context, state) {
          if (state.citiesState == RequestState.loading) {
            return const _LocationSkeleton();
          }

          if (state.citiesState == RequestState.error || state.cities.isEmpty) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _canScrollBack ? () => _scrollBy(-200.w) : null,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: _canScrollBack ? ColorManager.primary : Colors.grey,
                    size: 16,
                  ),
                ),

                Expanded(
                  child: SizedBox(
                    height: 0.12.sh,
                    child: ListView.separated(
                      clipBehavior: Clip.hardEdge,
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.cities.length,
                      separatorBuilder: (_, _) => SizedBox(width: 16.w),
                      itemBuilder: (context, index) {
                        final city = state.cities[index];
                        final isCurrentCity = state.currentCity?.name == city.name;

                        return GestureDetector(
                          onTap: () {
                            context.read<HomeCubit>().selectCity(city);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(3.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: isCurrentCity ? Border.all(color: ColorManager.green, width: 1.w) : null,
                                    ),
                                    child: ClipOval(
                                      child: CachedNetworkImage(imageUrl: city.image, fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ),
                              8.verticalSpace,
                              Text(city.name, style: Theme.of(context).textTheme.headlineSmall),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _canScrollForward ? () => _scrollBy(200.w) : null,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: _canScrollForward ? ColorManager.primary : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LocationSkeleton extends StatelessWidget {
  const _LocationSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: 0.12.sh,
        child: Skeletonizer(
          enabled: true,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, _) => SizedBox(width: 16.w),
            itemBuilder: (_, _) => const _CitySkeleton(),
          ),
        ),
      ),
    );
  }
}

class _CitySkeleton extends StatelessWidget {
  const _CitySkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
