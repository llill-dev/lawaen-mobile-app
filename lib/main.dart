import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/features/nearby/presentation/cubit/map_marker/map_marker_cubit.dart';

import 'app.dart';
import 'app/di/injection.dart';
import 'app/resources/language_manager.dart';

final navigatorKey = GlobalKey<NavigatorState>();
FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  // try {
  //   if (Firebase.apps.isEmpty) {
  //     await Firebase.initializeApp();
  //   }
  // } catch (e) {
  //   log(e.toString());
  // }

  HttpOverrides.global = MyHttpOverrides();

  await EasyLocalization.ensureInitialized();

  await configureInjection(Environment.prod);

  // await FirebaseMessagingService().initialize();

  getIt<MapMarkerCubit>().loadMarkers();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        ensureScreenSize: true,
        builder: (context, child) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: EasyLocalization(
            supportedLocales: const [arabicLocale, englishLocale],
            fallbackLocale: englishLocale,
            startLocale: englishLocale,

            path: assetPathLocalization,
            child: const MyApp(),
          ),
        ),
      ),
    );
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
