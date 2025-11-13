import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

import 'add_container.dart';

class DetermineLocation extends StatelessWidget {
  const DetermineLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return AddContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Location", style: Theme.of(context).textTheme.headlineMedium),
          24.verticalSpace,
          ClipRRect(borderRadius: BorderRadius.circular(8.r), child: Image.asset(ImageManager.addMap)),
          30.verticalSpace,
          Text(
            "The location will be determined accurately. Make sure that you have enabled location determination.",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
