import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/services/firebase_service.dart';
import 'package:lawaen/features/events/presentation/cubit/event_cubit/event_cubit.dart';
import 'package:lawaen/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:lawaen/features/nearby/presentation/cubit/map_marker/map_marker_cubit.dart';
import 'package:lawaen/features/offers/presentation/cubit/offers_cubit/offers_cubit.dart';

import 'app.dart';
import 'app/di/injection.dart';
import 'app/resources/language_manager.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  try {
    await Firebase.initializeApp();
  } catch (e) {
    log(e.toString());
  }

  HttpOverrides.global = MyHttpOverrides();

  await EasyLocalization.ensureInitialized();

  await configureInjection(Environment.prod);

  await FirebaseMessagingService().initialize();

  _initAppApi();

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

void _initAppApi() {
  getIt<MapMarkerCubit>().loadMarkers();
  getIt<EventCubit>().getEventTypes();
  getIt<OffersCubit>().getOfferTypes();
  getIt<ExploreCubit>().getUserPreferences();
}
