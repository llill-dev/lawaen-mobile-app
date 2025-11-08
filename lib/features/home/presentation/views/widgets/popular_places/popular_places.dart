import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../app/resources/assets_manager.dart';
import '../../../../../../app/resources/color_manager.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(color: ColorManager.black.withValues(alpha: 0.1), blurRadius: 6, offset: const Offset(0, 3)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: AspectRatio(
                  aspectRatio: 16 / 8,
                  child: Image.asset(ImageManager.place, fit: BoxFit.cover, width: double.infinity),
                ),
              ),
              15.h.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Elite Hotel', style: Theme.of(context).textTheme.headlineMedium),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorManager.reatingAvaterColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          child: Row(
                            children: [
                              SvgPicture.asset(IconManager.star),
                              SizedBox(width: 4.w),
                              Text('4.5', style: Theme.of(context).textTheme.headlineMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                    8.h.verticalSpace,
                    Text("Hotel", style: Theme.of(context).textTheme.headlineSmall),
                    8.h.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(IconManager.location, color: ColorManager.grey),
                              SizedBox(width: 4.w),
                              Text('2.5 km', style: Theme.of(context).textTheme.headlineSmall),
                            ],
                          ),
                        ),
                        Text('225 reviews', style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                    12.h.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(IconManager.location, color: ColorManager.white, width: 16.w),
                                SizedBox(width: 6.w),
                                Text(
                                  'Directions',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        8.horizontalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            border: Border.all(color: const Color(0xff7BBF33).withValues(alpha: 0.3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(IconManager.phone, width: 20.w, height: 20.h),
                        ),
                      ],
                    ),
                    12.h.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
