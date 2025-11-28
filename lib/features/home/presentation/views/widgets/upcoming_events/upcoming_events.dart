import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import '../../../../../../app/resources/assets_manager.dart';
import 'event_item.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Map<String, dynamic>> events = [
    {'image': ImageManager.events, 'day': '10', 'month': 'Dec', 'title': 'Fairuz and the love'},
    {'image': ImageManager.events, 'day': '15', 'month': 'Dec', 'title': 'Winter Concert'},
    {'image': ImageManager.events, 'day': '20', 'month': 'Dec', 'title': 'Christmas Special'},
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  void _goToNextPage() {
    if (_currentPage < events.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming Events', style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: 5.h),
          AspectRatio(
            aspectRatio: 16 / 7,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return EventItem(
                      image: event['image'],
                      day: event['day'],
                      month: event['month'],
                      title: event['title'],
                      goToNextPage: _goToNextPage,
                    );
                  },
                ),
                Positioned(
                  bottom: 12.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(events.length, (index) {
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
}
