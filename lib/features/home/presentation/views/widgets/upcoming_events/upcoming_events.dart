import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'event_item.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  // void _goToNextPage(int lenght) {
  //   if (_currentPage < lenght) {
  //     _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  //   } else {
  //     _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  //   }
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.evetnsState == RequestState.success) {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.upcomingEvents.tr(), style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: 5.h),
                AspectRatio(
                  aspectRatio: 16 / 7,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: state.events.length,
                        itemBuilder: (context, index) {
                          final event = state.events[index];
                          return EventItem(eventModel: event);
                        },
                      ),
                      Positioned(
                        bottom: 12.h,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(state.events.length, (index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index ? ColorManager.white : Colors.white.withValues(alpha: 0.5),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).horizontalPadding(padding: 16.w),
          );
        }
        if (state.eventsError != null && state.evetnsState == RequestState.error) {
          SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return SliverToBoxAdapter(
          child: RedactedBox(
            child: Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(16.r)),
            ),
          ),
        );
      },
    );
  }
}
