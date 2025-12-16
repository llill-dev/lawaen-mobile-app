import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'open_map_widget.dart';
import 'weather_widget.dart';

class WeatherAndMap extends StatelessWidget {
  const WeatherAndMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: const WeatherWidget().horizontalPadding(padding: 16.w));
  }
}
