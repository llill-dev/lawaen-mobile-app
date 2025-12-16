import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';

import '../../../../../../app/resources/assets_manager.dart';

class EventItem extends StatelessWidget {
  final EventModel eventModel;
  //final void Function(int)? goToNextPage;
  const EventItem({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(EventsDetailsRoute(event: eventModel)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Stack(
          children: [
            if (eventModel.image != null && eventModel.image!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10.r),
                child: NetworkIcon(url: eventModel.image!, fit: BoxFit.cover, width: double.infinity),
              )
            else
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(image: AssetImage(ImageManager.emptyPhoto), fit: BoxFit.cover),
                ),
              ),
            Positioned(
              top: 12.h,
              left: 7.w,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.green.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(safeDay(eventModel.startDate), style: Theme.of(context).textTheme.bodyLarge),
                    Text(
                      safeMonthName(eventModel.startDate),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            if (eventModel.name != null)
              Positioned(
                top: 12.h,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  child: Text(
                    eventModel.name!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            // Positioned(
            //   bottom: 12.h,
            //   right: 12.w,
            //   child: GestureDetector(
            //     onTap: goToNextPage,
            //     child: CircleAvatar(
            //       backgroundColor: ColorManager.lightGrey,
            //       radius: 13.r,
            //       child: SvgPicture.asset(IconManager.forward),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
