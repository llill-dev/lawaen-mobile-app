import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';

import '../../../../../../app/resources/color_manager.dart';

class ServicesSection extends StatelessWidget {
  final ItemData itemData;
  const ServicesSection({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    final services = itemData.ui?.options ?? [];
    if (services.isEmpty) return SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(18.w),
      margin: EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorManager.primary),
        boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 4, offset: Offset(0, 4))],
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        clipBehavior: Clip.none,
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
          if (services[index].title == null) return SizedBox.shrink();
          return ServicesItem(serviceTitle: services[index].title!);
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
