import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (prev, curr) =>
            prev.weatherState != curr.weatherState ||
            prev.weather != curr.weather ||
            prev.weatherError != curr.weatherError,
        builder: (context, state) {
          if (state.weatherState == RequestState.error) {
            return const SizedBox.shrink();
          }

          if (state.weatherState == RequestState.loading) {
            return _WeatherLoadingSkeleton();
          }

          if (state.weatherState == RequestState.success && state.weather != null) {
            final temperature = state.weather!.currentWeather.temperature.round();

            return _WeatherContent(temperature: temperature);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _WeatherLoadingSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: RedactedBox(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r), color: ColorManager.lightGrey),
          padding: EdgeInsets.all(15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(width: 40.w, height: 12.h),
              ShimmerBox(width: 60.w, height: 60.w),
              ShimmerBox(width: 50.w, height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherContent extends StatelessWidget {
  final int temperature;

  const _WeatherContent({required this.temperature});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ColorManager.wheatherUpGradient,
              ),
            ),
          ),

          Positioned(
            top: 8.h,
            child: Text(
              LocaleKeys.now.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorManager.white),
            ),
          ),

          // ⚠️ ICON WILL BE ADDED LATER
          /*
          Padding(
            padding: EdgeInsets.all(15.w),
            child: SvgPicture.asset(
              IconManager.weather,
              fit: BoxFit.contain,
            ),
          ),
          */
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 0.45.sh * 0.20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: ColorManager.wheatherDownGradient,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "$temperature°",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: ColorManager.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
