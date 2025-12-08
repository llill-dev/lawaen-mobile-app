import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';

class EventDetailsImageSection extends StatelessWidget {
  final EventModel event;

  const EventDetailsImageSection({super.key, required this.event});

  Widget _buildImage() {
    final img = event.image;

    if (img == null || img.trim().isEmpty) {
      return Image.asset(ImageManager.events, fit: BoxFit.fill, width: double.infinity);
    }

    return NetworkIcon(url: img, fit: BoxFit.cover, width: double.infinity);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          AspectRatio(aspectRatio: 16 / 9, child: _buildImage()),
          Positioned(
            top: 8.h,
            left: 4.w,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(color: ColorManager.white, shape: BoxShape.circle),
                child: Icon(Icons.arrow_back, color: ColorManager.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
