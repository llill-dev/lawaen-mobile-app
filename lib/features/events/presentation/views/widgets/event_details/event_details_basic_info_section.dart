import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/functions/url_launcher.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';

class EventDetailsBasicInfoSection extends StatelessWidget {
  final EventModel event;
  final String? address;

  const EventDetailsBasicInfoSection({super.key, required this.event, this.address});

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return "";
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsed);
    } catch (_) {
      return date;
    }
  }

  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return "";
    DateTime? parsed;

    try {
      parsed = DateFormat('HH:mm').parse(time);
    } catch (_) {
      try {
        parsed = DateFormat('hh:mm a').parse(time);
      } catch (_) {
        return time;
      }
    }

    return DateFormat('hh:mm a').format(parsed);
  }

  String _formatTimeRange(String? start, String? end) {
    final s = _formatTime(start);
    final e = _formatTime(end);

    if (s.isNotEmpty && e.isNotEmpty) return "$s - $e";
    if (s.isNotEmpty) return s;
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final startDateText = _formatDate(event.startDate);
    final endDateText = _formatDate(event.endDate);
    final timeText = _formatTimeRange(event.startTime, event.endTime);
    final place = address?.trim() ?? "";
    final phone = event.phone?.trim() ?? "";

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (event.name != null && event.name!.trim().isNotEmpty)
            Text(event.name!, style: Theme.of(context).textTheme.displayLarge),
          if (event.name != null && event.name!.trim().isNotEmpty) 12.verticalSpace,

          if (startDateText.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.date_range_outlined, color: ColorManager.grey, size: 19.r),
                6.horizontalSpace,
                Text(startDateText, style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            12.verticalSpace,
          ],
          if (endDateText.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.date_range_outlined, color: ColorManager.grey, size: 19.r),
                6.horizontalSpace,
                Text(endDateText, style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            12.verticalSpace,
          ],

          if (timeText.isNotEmpty)
            Row(
              children: [
                Icon(Icons.watch_later_outlined, color: ColorManager.grey, size: 19.r),
                6.horizontalSpace,
                Text(timeText, style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          if (timeText.isNotEmpty) 12.verticalSpace,

          if (place.isNotEmpty)
            Row(
              children: [
                SvgPicture.asset(
                  IconManager.location,
                  colorFilter: ColorFilter.mode(ColorManager.green, BlendMode.srcIn),
                ),
                6.horizontalSpace,
                Expanded(
                  child: Text(
                    place,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.green),
                  ),
                ),
              ],
            ),
          if (place.isNotEmpty) 12.verticalSpace,

          if (phone.isNotEmpty)
            Row(
              children: [
                GestureDetector(onTap: () => makePhoneCall(phone), child: SvgPicture.asset(IconManager.phoneIcon)),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    phone,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
        ],
      ).horizontalPadding(padding: 16.w),
    );
  }
}
