import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

class WeatherImageHelper {
  static Widget getWeatherImage({required int weatherCode, required int temperature}) {
    final size = 100.w;
    // Clear sky
    if (weatherCode == 0) {
      return SvgPicture.asset(IconManager.weatherSunny, width: size - 20, height: size - 20);
    }

    // Partly cloudy / overcast
    if (weatherCode >= 1 && weatherCode <= 3) {
      return SvgPicture.asset(IconManager.weatherPartlyCloudy, width: size, height: size);
    }

    // Fog
    if (weatherCode == 45 || weatherCode == 48) {
      return SvgPicture.asset(IconManager.weatherCloudy, width: size, height: size);
    }

    // Rain & drizzle
    if ((weatherCode >= 51 && weatherCode <= 67) || (weatherCode >= 80 && weatherCode <= 82)) {
      return SvgPicture.asset(IconManager.weatherRainy, width: size, height: size);
    }

    // Snow
    if ((weatherCode >= 71 && weatherCode <= 77) || (weatherCode >= 85 && weatherCode <= 86)) {
      return Image.asset(ImageManager.weatherSnowy, width: size + 20, height: size + 20);
    }

    // Thunderstorm
    if (weatherCode >= 95 && weatherCode <= 99) {
      return SvgPicture.asset(IconManager.weatherThunder, width: size, height: size);
    }

    // Fallback
    return SvgPicture.asset(IconManager.weatherCloudy, width: size, height: size);
  }
}
