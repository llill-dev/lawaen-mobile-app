import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app/di/injection.dart';
import 'app/resources/theme_manager.dart';
import 'app/routes/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Lawaen",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: getApplicationTheme(),
      routerConfig: getIt<AppRouter>().config(),
    );
  }
}
