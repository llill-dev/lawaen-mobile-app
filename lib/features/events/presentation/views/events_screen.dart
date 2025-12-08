import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/core/widgets/error_view.dart';
import 'package:lawaen/app/core/widgets/grid_and_list_buttons_with_title.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/features/events/presentation/cubit/event_cubit/event_cubit.dart';
import 'package:lawaen/features/events/presentation/views/widgets/empty_event.dart';
import 'package:lawaen/features/events/presentation/views/widgets/event_type.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'widgets/events_item.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _isGridView = false;
  int _selectedEventTypeIndex = 0;

  late final EventCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<EventCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.state.eventTypes.isNotEmpty) {
        final firstTypeId = cubit.state.eventTypes.first.id;
        cubit.getEvents(eventTypeId: firstTypeId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        final eventTypes = state.eventTypes.map((e) => e.name).toList();
        final events = state.events;
        final isLoading = state.eventsState == RequestState.loading;
        final isError = state.eventsError != null || state.eventsState == RequestState.error;
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
                        title: LocaleKeys.events.tr(),
                        onViewModeChanged: isLoading ? (v) {} : _onViewModeChanged,
                      ),

                      16.verticalSpace,

                      SizedBox(
                        height: 35.h,
                        child: ListView.separated(
                          separatorBuilder: (_, _) => 12.horizontalSpace,
                          scrollDirection: Axis.horizontal,
                          itemCount: eventTypes.length,
                          itemBuilder: (context, index) => EventType(
                            isSelected: index == _selectedEventTypeIndex,
                            eventType: eventTypes[index],
                            onTap: isLoading ? () {} : () => _onEventTypeChanged(index),
                          ),
                        ),
                      ),
                    ],
                  ).horizontalPadding(padding: 16.w),
                ),

                buildSpace(),

                if (isLoading)
                  _buildListShimmer()
                else if (isError)
                  _buildErrorWidget(
                    state.eventsError,
                    () => cubit.getEvents(eventTypeId: cubit.state.eventTypes[_selectedEventTypeIndex].id),
                  )
                else if (events.isEmpty)
                  _buildEmptyState()
                else if (_isGridView)
                  _buildGridView(events)
                else
                  _buildListView(events),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------- LOGIC ----------------------

  void _onViewModeChanged(bool isGrid) {
    if (_isGridView == isGrid) return;
    setState(() => _isGridView = isGrid);
  }

  void _onEventTypeChanged(int index) {
    if (_selectedEventTypeIndex == index) return;

    setState(() => _selectedEventTypeIndex = index);

    final selectedTypeId = cubit.state.eventTypes[_selectedEventTypeIndex].id;

    cubit.getEvents(eventTypeId: selectedTypeId);
  }

  // ---------------------- UI COMPONENTS ----------------------

  Widget _buildEmptyState() {
    return SliverFillRemaining(hasScrollBody: false, child: Center(child: EmptyEvent()));
  }

  Widget _buildGridView(List<EventModel> events) {
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
          (context, index) => EventsItem(isGridView: true, event: events[index]),
          childCount: events.length,
        ),
      ),
    );
  }

  Widget _buildListView(List<EventModel> events) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: SliverList.separated(
        itemCount: events.length,
        separatorBuilder: (_, _) => 12.verticalSpace,
        itemBuilder: (context, index) => EventsItem(isGridView: false, event: events[index]),
      ),
    );
  }

  Widget _buildListShimmer() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: SliverList.separated(
        itemCount: 6,
        separatorBuilder: (_, _) => 12.verticalSpace,
        itemBuilder: (_, _) => RedactedBox(
          child: Container(
            height: 170.h,
            width: double.infinity,
            decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(16.r)),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String? errorMsg, VoidCallback onRetry) {
    return ErrorView(errorMsg: errorMsg, onRetry: onRetry);
  }
}
