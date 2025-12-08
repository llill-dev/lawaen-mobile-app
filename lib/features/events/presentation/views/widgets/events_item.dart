import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';

class EventsItem extends StatefulWidget {
  final bool isGridView;
  final EventModel event;

  const EventsItem({super.key, required this.isGridView, required this.event});

  @override
  State<EventsItem> createState() => _EventsItemState();
}

class _EventsItemState extends State<EventsItem> {
  // String? _locationName;
  // bool _locationLoading = true;

  late final String _month;
  late final String _day;

  @override
  void initState() {
    super.initState();
    _extractFormattedDate();
    //_loadLocation();
  }

  void _extractFormattedDate() {
    _month = safeMonthName(widget.event.startDate);
    _day = safeDay(widget.event.startDate);
  }

  // Future<void> _loadLocation() async {
  //   final event = widget.event;

  //   if (event.latitude == null || event.longitude == null) {
  //     setState(() => _locationLoading = false);
  //     return;
  //   }

  //   try {
  //     final locService = getIt<LocationService>();

  //     final String name = await locService
  //         .getAddressFromCoordinates(latitude: event.latitude!, longitude: event.longitude!)
  //         .timeout(const Duration(seconds: 3), onTimeout: () => "");

  //     if (!mounted) return;

  //     setState(() {
  //       _locationName = name.isNotEmpty ? name : null;
  //       _locationLoading = false;
  //     });
  //   } catch (e) {
  //     if (mounted) {
  //       setState(() {
  //         _locationLoading = false;
  //         _locationName = null;
  //       });
  //     }
  //   }
  // }

  Widget _buildEventImage() {
    final img = widget.event.image;

    if (img == null || img.trim().isEmpty) {
      return Image.asset(ImageManager.emptyPhoto, fit: BoxFit.cover, width: double.infinity);
    }

    return NetworkIcon(url: img, fit: BoxFit.cover, width: double.infinity);
  }

  // Widget _buildLocation() {
  //   if (_locationLoading) return const SizedBox.shrink();
  //   if (_locationName == null) return const SizedBox.shrink();

  //   return Row(
  //     children: [
  //       SvgPicture.asset(IconManager.location, colorFilter: ColorFilter.mode(ColorManager.green, BlendMode.srcIn)),
  //       6.horizontalSpace,
  //       Expanded(
  //         child: Text(
  //           _locationName!,
  //           style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorManager.green),
  //           maxLines: 1,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildDateBadge() {
    if (_month.isEmpty || _day.isEmpty) return const SizedBox.shrink();

    return Positioned(
      top: 8.h,
      left: 8.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: ColorManager.primary.withValues(alpha: .7),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_month, style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.white)),
            4.verticalSpace,
            Text(_day, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.r);

    final content = GestureDetector(
      onTap: () => context.pushRoute(EventsDetailsRoute(event: widget.event)),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            Positioned.fill(child: _buildEventImage()),
            _buildDateBadge(),

            if (widget.event.name != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(color: ColorManager.primary.withValues(alpha: .7)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.event.name!,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white),
                      ),
                      6.verticalSpace,
                      //_buildLocation(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    return widget.isGridView ? content : SizedBox(height: 170.h, width: double.infinity, child: content);
  }
}
