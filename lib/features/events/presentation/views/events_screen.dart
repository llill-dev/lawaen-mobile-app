import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/core/widgets/grid_and_list_buttons_with_title.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/features/events/presentation/views/widgets/event_type.dart';

import 'widgets/events_item.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  bool _isGridView = true;
  static const int _eventsCount = 8;
  final List<String> _eventTypes = const ['Culture', 'Music', 'Children', 'Sports', 'Business', 'Food'];
  int _selectedEventTypeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  GridAndListButtonsWithTitle(
                    isGridView: _isGridView,
                    onViewModeChanged: _onViewModeChanged,
                    title: 'Events',
                  ),
                  16.verticalSpace,
                  SizedBox(
                    height: 35.h,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => 12.horizontalSpace,
                      scrollDirection: Axis.horizontal,
                      itemCount: _eventTypes.length,
                      itemBuilder: (context, index) => EventType(
                        isSelected: index == _selectedEventTypeIndex,
                        eventType: _eventTypes[index],
                        onTap: () => _onEventTypeChanged(index),
                      ),
                    ),
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

  void _onEventTypeChanged(int index) {
    if (_selectedEventTypeIndex == index) return;
    setState(() {
      _selectedEventTypeIndex = index;
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
          (context, index) => EventsItem(isGridView: true),
          childCount: _eventsCount,
        ),
      ),
    );
  }

  Widget _buildListView() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: SliverList.separated(
        itemCount: _eventsCount,
        separatorBuilder: (context, index) => 12.verticalSpace,
        itemBuilder: (context, index) => EventsItem(isGridView: false),
      ),
    );
  }
}
