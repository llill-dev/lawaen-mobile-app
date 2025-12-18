import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/functions/url_launcher.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

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
    final organization = event.organization?.trim() ?? "";
    final place = address?.trim() ?? "";
    final phone = event.phone?.trim() ?? "";
    final instagram = event.instagram?.trim() ?? "";
    final facebook = event.facebook?.trim() ?? "";
    final whatsapp = event.whatsapp?.trim() ?? "";

    Widget buildGreenIconContainer(Widget icon) {
      return Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(color: ColorManager.green, borderRadius: BorderRadius.circular(8.r)),
        child: icon,
      );
    }

    Widget buildSocialIconButton({required String iconPath, required VoidCallback onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: ColorManager.blackSwatch[4]!),
          ),
          child: SvgPicture.asset(
            iconPath,
            width: 22.w,
            height: 22.h,
            //colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
          ),
        ),
      );
    }

    final contactWidgets = <Widget>[];
    void addContactWidget(Widget widget) {
      if (contactWidgets.isNotEmpty) {
        contactWidgets.add(8.horizontalSpace);
      }
      contactWidgets.add(widget);
    }

    if (event.latitude != null && event.longitude != null) {
      addContactWidget(
        GestureDetector(
          onTap: () async {
            await getIt<LocationService>().openLocationInMaps(latitude: event.latitude!, longitude: event.longitude!);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorManager.blackSwatch[4]!),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined, size: 20, color: ColorManager.white),
                10.horizontalSpace,
                Text(
                  LocaleKeys.location.tr(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (phone.isNotEmpty) {
      addContactWidget(
        GestureDetector(
          onTap: () => makePhoneCall(phone),
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorManager.blackSwatch[4]!),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  width: 16.w,
                  height: 16.h,
                  IconManager.phoneIcon,
                  colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
                ),
                4.horizontalSpace,
                Text(
                  LocaleKeys.phoneNumber.tr(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.primary),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (instagram.isNotEmpty) {
      addContactWidget(
        buildSocialIconButton(
          iconPath: IconManager.insta,
          onTap: () => launchURL(link: instagram),
        ),
      );
    }

    if (facebook.isNotEmpty) {
      addContactWidget(
        buildSocialIconButton(
          iconPath: IconManager.facebook,
          onTap: () => launchURL(link: facebook),
        ),
      );
    }

    if (whatsapp.isNotEmpty) {
      addContactWidget(
        buildSocialIconButton(
          iconPath: IconManager.whatsApp,
          onTap: () => launchURL(link: whatsapp),
        ),
      );
    }

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
                buildGreenIconContainer(Icon(Icons.date_range_outlined, color: ColorManager.white, size: 18.r)),
                6.horizontalSpace,
                Text(startDateText, style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
            12.verticalSpace,
          ],
          if (endDateText.isNotEmpty) ...[
            Row(
              children: [
                buildGreenIconContainer(Icon(Icons.date_range_outlined, color: ColorManager.white, size: 18.r)),
                6.horizontalSpace,
                Text(endDateText, style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
            12.verticalSpace,
          ],

          if (timeText.isNotEmpty)
            Row(
              children: [
                buildGreenIconContainer(Icon(Icons.watch_later_outlined, color: ColorManager.white, size: 18.r)),
                6.horizontalSpace,
                Text(timeText, style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
          if (timeText.isNotEmpty) 12.verticalSpace,

          if (organization.isNotEmpty)
            Row(
              children: [
                buildGreenIconContainer(Icon(Icons.business_outlined, color: ColorManager.white, size: 18.r)),
                6.horizontalSpace,
                Expanded(
                  child: Text(
                    organization,
                    style: Theme.of(context).textTheme.headlineMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          if (organization.isNotEmpty) 12.verticalSpace,

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
          // if (place.isNotEmpty) 12.verticalSpace,

          // if (phone.isNotEmpty)
          //   Row(
          //     children: [
          //       GestureDetector(onTap: () => makePhoneCall(phone), child: SvgPicture.asset(IconManager.phoneIcon)),
          //       8.horizontalSpace,
          //       Expanded(
          //         child: Text(
          //           phone,
          //           style: Theme.of(context).textTheme.headlineSmall,
          //           maxLines: 1,
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //       ),
          //     ],
          //   ),
          12.verticalSpace,
          if (contactWidgets.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: contactWidgets),
            ),
        ],
      ).horizontalPadding(padding: 16.w),
    );
  }
}
