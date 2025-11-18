import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class EventType extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String eventType;
  const EventType({super.key, required this.isSelected, required this.onTap, required this.eventType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : ColorManager.blackSwatch[3],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            eventType,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: isSelected ? ColorManager.white : ColorManager.darkGrey),
          ),
        ),
      ),
    );
  }
}
