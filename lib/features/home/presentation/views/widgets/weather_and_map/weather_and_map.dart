import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'open_map_widget.dart';
import 'weather_widget.dart';

class WeatherAndMap extends StatelessWidget {
  const WeatherAndMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OpenMapWidget(),
        SizedBox(width: 10.w),
        const WeatherWidget(),
      ],
    );
  }
}
