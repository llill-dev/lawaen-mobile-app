import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/features/events/presentation/views/widgets/event_details/event_details_basic_info_section.dart';
import 'package:lawaen/features/events/presentation/views/widgets/event_details/event_details_image_section.dart';
import 'package:lawaen/features/events/presentation/views/widgets/event_details/event_info_section.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_item_details/loctaion_item_section.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_item_details/section_selector.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class EventsDetailsScreen extends StatefulWidget {
  final EventModel event;
  final String? address;

  const EventsDetailsScreen({super.key, required this.event, this.address});

  @override
  State<EventsDetailsScreen> createState() => _EventsDetailsScreenState();
}

class _EventsDetailsScreenState extends State<EventsDetailsScreen> {
  int selectedIndex = 0;
  final List<String> sections = [LocaleKeys.information.tr(), LocaleKeys.location.tr()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            EventDetailsImageSection(event: widget.event),
            buildSpace(),
            EventDetailsBasicInfoSection(event: widget.event, address: widget.address),
            buildSpace(),
            SectionSelector(
              sections: sections,
              selectedIndex: selectedIndex,
              onSectionSelected: (index) => setState(() => selectedIndex = index),
            ),
            buildSpace(),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: IndexedStack(
                  index: selectedIndex,
                  children: [
                    EventInfoSection(description: widget.event.description, note: widget.event.note),
                    LocationItemSection(latitude: widget.event.latitude, longitude: widget.event.longitude),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class EventDetailsImageSection extends StatelessWidget {
//   const EventDetailsImageSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Stack(
//         children: [
//           AspectRatio(
//             aspectRatio: 16 / 9,
//             child: Image.asset(ImageManager.events, fit: BoxFit.fill, width: double.infinity),
//           ),
//           Positioned(
//             top: 8.h,
//             left: 4.w,
//             child: GestureDetector(
//               onTap: () => context.pop(),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//                 decoration: BoxDecoration(color: ColorManager.white, shape: BoxShape.circle),
//                 child: Icon(Icons.arrow_back, color: ColorManager.black),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EventDetailsBasicInfoSection extends StatelessWidget {
//   const EventDetailsBasicInfoSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Fairuz and the love", style: Theme.of(context).textTheme.displayLarge),
//           12.verticalSpace,
//           Row(
//             children: [
//               Icon(Icons.date_range_outlined, color: ColorManager.grey, size: 19.r),
//               6.horizontalSpace,
//               Text("10 JUN 2025", style: Theme.of(context).textTheme.headlineSmall),
//             ],
//           ),
//           12.verticalSpace,
//           Row(
//             children: [
//               Icon(Icons.watch_later_outlined, color: ColorManager.grey, size: 19.r),
//               6.horizontalSpace,
//               Text("10:00 AM - 12:00 PM", style: Theme.of(context).textTheme.headlineSmall),
//             ],
//           ),
//           12.verticalSpace,
//           Row(
//             children: [
//               SvgPicture.asset(
//                 IconManager.location,
//                 colorFilter: ColorFilter.mode(ColorManager.green, BlendMode.srcIn),
//               ),
//               6.horizontalSpace,
//               Expanded(
//                 child: Text(
//                   "Aleppo",
//                   style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.green),
//                 ),
//               ),
//             ],
//           ),
//           12.verticalSpace,
//           Row(
//             children: [
//               SvgPicture.asset(IconManager.phoneIcon),
//               8.horizontalSpace,
//               SvgPicture.asset(IconManager.facebook),
//               8.horizontalSpace,
//               SvgPicture.asset(IconManager.insta),
//               8.horizontalSpace,
//               SvgPicture.asset(IconManager.whatsApp),
//             ],
//           ),
//         ],
//       ).horizontalPadding(padding: 16.w),
//     );
//   }
// }
