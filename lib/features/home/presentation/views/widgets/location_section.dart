import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/resources/assets_manager.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = List.generate(5, (index) => 'Damascus');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: 0.12.sh,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: locations.length,
          separatorBuilder: (_, _) => SizedBox(width: 16.w),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Expanded(child: AspectRatio(aspectRatio: 1, child: Image.asset(ImageManager.damas))),
                SizedBox(height: 8.h),
                Text(locations[index], style: Theme.of(context).textTheme.headlineSmall),
              ],
            );
          },
        ),
      ),
    );
  }
}
