import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'add_container.dart';

class DetermineLocation extends StatelessWidget {
  const DetermineLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return AddContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.location.tr(), style: Theme.of(context).textTheme.headlineMedium),
          24.verticalSpace,
          ClipRRect(borderRadius: BorderRadius.circular(8.r), child: Image.asset(ImageManager.addMap)),
          30.verticalSpace,
          Text(
            LocaleKeys.locationHint.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
