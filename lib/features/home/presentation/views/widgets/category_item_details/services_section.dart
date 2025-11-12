import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../app/resources/color_manager.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      "Teeth Whitening ",
      "Cleaning",
      "X-ray",
      "Consultation",
      "Braces",
      "Swimming Pool",
      "Spa & Wellness",
      "Beach Access",
      "Fitness Center",
    ];
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorManager.primary),
        boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 4, offset: Offset(0, 4))],
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: services.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          mainAxisExtent: 45.h,
        ),
        itemBuilder: (context, index) {
          return ServicesItem(serviceTitle: services[index]);
        },
      ),
    );
  }
}

class ServicesItem extends StatelessWidget {
  final String serviceTitle;
  const ServicesItem({super.key, required this.serviceTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: ColorManager.secondary.withValues(alpha: .25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(shape: BoxShape.circle, color: ColorManager.primary),
          ),
          5.horizontalSpace,
          Flexible(
            child: Text(
              serviceTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.black),
            ),
          ),
        ],
      ),
    );
  }
}
