import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

class WeatherImageHelper {
  static Widget getWeatherImage({required int weatherCode, required int temperature, double? size}) {
    // Clear sky
    if (weatherCode == 0) {
      return Image.asset(ImageManager.weatherSunny, fit: BoxFit.contain, width: size ?? 40.w, height: size ?? 40.w);
    }

    // Partly cloudy / overcast
    if (weatherCode >= 1 && weatherCode <= 3) {
      return Image.asset(
        ImageManager.weatherPartlyCloudy,
        fit: BoxFit.contain,
        width: size ?? 60.w,
        height: size ?? 60.w,
      );
    }

    // Fog
    if (weatherCode == 45 || weatherCode == 48) {
      return Image.asset(ImageManager.weatherCloudy, fit: BoxFit.contain, width: size ?? 60.w, height: size ?? 60.w);
    }

    // Rain & drizzle
    if ((weatherCode >= 51 && weatherCode <= 67) || (weatherCode >= 80 && weatherCode <= 82)) {
      return Image.asset(ImageManager.weatherRainy, fit: BoxFit.contain, width: size ?? 55.w, height: size ?? 55.w);
    }

    // Snow
    if ((weatherCode >= 71 && weatherCode <= 77) || (weatherCode >= 85 && weatherCode <= 86)) {
      return Image.asset(ImageManager.weatherSnowy, fit: BoxFit.contain, width: size ?? 60.w, height: size ?? 60.w);
    }

    // Thunderstorm
    if (weatherCode >= 95 && weatherCode <= 99) {
      return Image.asset(ImageManager.weatherThunder, fit: BoxFit.contain, width: size ?? 55.w, height: size ?? 55.w);
    }

    // Fallback
    return Image.asset(ImageManager.weatherCloudy, fit: BoxFit.contain, width: size ?? 60.w, height: size ?? 60.w);
  }
}
