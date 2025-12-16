import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/helper/weather_image_helper.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/resources/language_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, curr) =>
          prev.weatherState != curr.weatherState ||
          prev.weather != curr.weather ||
          prev.weatherError != curr.weatherError ||
          prev.currentCity != curr.currentCity,
      builder: (context, state) {
        if (state.weatherState == RequestState.error) {
          return const SizedBox.shrink();
        }

        if (state.weatherState == RequestState.loading) {
          return const _WeatherLoadingSkeleton();
        }

        if (state.weatherState == RequestState.success && state.weather != null) {
          final temperature = state.weather!.currentWeather.temperature.round();
          final weatherCode = state.weather!.currentWeather.weathercode;
          final cityName = state.currentCity?.name;

          return _WeatherContent(temperature: temperature, weatherCode: weatherCode, cityName: cityName);
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _WeatherLoadingSkeleton extends StatelessWidget {
  const _WeatherLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 95.h,
      child: RedactedBox(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              colors: [ColorManager.nPrimarySwatch[2]!, ColorManager.nPrimarySwatch[4]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: ColorManager.notificationBorderColor),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerBox(width: 110.w, height: 14.h),
                    SizedBox(height: 8.h),
                    ShimmerBox(width: 80.w, height: 12.h),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ColorManager.notificationBorderColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShimmerBox(width: 32.w, height: 32.w),
                    SizedBox(width: 8.w),
                    ShimmerBox(width: 36.w, height: 22.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _WeatherContent extends StatelessWidget {
//   final int temperature;
//   final int weatherCode;
//   const _WeatherContent({required this.temperature, required this.weatherCode});
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 0.75,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25.r),
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: ColorManager.wheatherUpGradient,
//               ),
//             ),
//           ),
//
//           Positioned(
//             top: 8.h,
//             child: Text(
//               LocaleKeys.now.tr(),
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorManager.white),
//             ),
//           ),
//
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: 0.45.sh * 0.20,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25.r),
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.topRight,
//                   colors: ColorManager.wheatherDownGradient,
//                 ),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 "$temperature°",
//                 style: Theme.of(context).textTheme.displayLarge?.copyWith(
//                   color: ColorManager.white,
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//
//           WeatherImageHelper.getWeatherImage(weatherCode: weatherCode, temperature: temperature),
//         ],
//       ),
//     );
//   }
// }

class _WeatherContent extends StatelessWidget {
  final int temperature;
  final int weatherCode;
  final String? cityName;

  const _WeatherContent({required this.temperature, required this.weatherCode, this.cityName});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final resolvedCity = (cityName?.isNotEmpty ?? false) ? cityName! : LocaleKeys.now.tr();
    final lang = getIt<AppPreferences>().getAppLanguage();

    return Container(
      width: double.infinity,
      height: 95.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorManager.primary),
        gradient: LinearGradient(
          colors: [ColorManager.primary, ColorManager.white],

          begin: lang == english ? Alignment.topLeft : Alignment.topRight,
          end: lang == english ? Alignment.bottomRight : Alignment.bottomLeft,
        ),

        boxShadow: [
          BoxShadow(color: ColorManager.primary.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.CurrentWeather.tr(),
                style: textTheme.titleSmall?.copyWith(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                resolvedCity,
                style: textTheme.bodyMedium?.copyWith(color: ColorManager.black, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          WeatherImageHelper.getWeatherImage(weatherCode: weatherCode, temperature: temperature),

          SizedBox(width: 10.w),
          Text(
            "$temperature°",
            style: textTheme.headlineLarge?.copyWith(
              color: ColorManager.darkGrey,
              fontWeight: FontWeight.w700,
              fontSize: 28.sp,
            ),
          ),
        ],
      ),
    );
  }
}
