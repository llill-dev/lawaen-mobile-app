import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';

class ExploreItem extends StatelessWidget {
  const ExploreItem({super.key, this.isGridView = true});

  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(CategoryItemDetialsRoute()),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 0.1),
              offset: const Offset(0, 1),
              spreadRadius: -1,
              blurRadius: 2,
            ),

            BoxShadow(color: ColorManager.black.withValues(alpha: 0.25), offset: const Offset(0, 1), blurRadius: 4),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                  child: Image.asset(ImageManager.place, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: ColorManager.red, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconManager.trending),
                        4.horizontalSpace,
                        Text(
                          'Trending',
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: ColorManager.white, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconManager.star),
                        4.horizontalSpace,
                        Text(
                          '4.9',
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Luxury hotels",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.black),
                ),
                4.verticalSpace,
                Text("old Damascus", style: Theme.of(context).textTheme.headlineSmall),
                4.verticalSpace,
                Text("Colsed now", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.red)),
                if (!isGridView) 12.verticalSpace,
              ],
            ).horizontalPadding(padding: 16.w),
          ],
        ),
      ),
    );
  }
}
