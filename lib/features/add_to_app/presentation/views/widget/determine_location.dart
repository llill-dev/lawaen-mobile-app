import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'add_container.dart';

class LocationPickerField extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  final void Function(double lat, double lng) onLocationSelected;

  const LocationPickerField({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.onLocationSelected,
  });

  Future<void> _openMap(BuildContext context) async {
    final result = await context.pushRoute(MapPickerRoute(initialLatitude: latitude, initialLongitude: longitude));

    if (result is Map && result['lat'] is double && result['lng'] is double) {
      onLocationSelected(result['lat'] as double, result['lng'] as double);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.location.tr(), style: Theme.of(context).textTheme.headlineMedium),
          12.verticalSpace,
          if (latitude != null && longitude != null)
            Text(
              '${LocaleKeys.location.tr()}: ${latitude!.toStringAsFixed(5)}, ${longitude!.toStringAsFixed(5)}',
              style: Theme.of(context).textTheme.headlineSmall,
            )
          else
            Text(LocaleKeys.locationHint.tr(), style: Theme.of(context).textTheme.headlineSmall),
          16.verticalSpace,
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: ColorManager.primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              onPressed: () => _openMap(context),
              child: Text(
                latitude == null ? LocaleKeys.chooseLocation.tr() : LocaleKeys.changeLocation.tr(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
