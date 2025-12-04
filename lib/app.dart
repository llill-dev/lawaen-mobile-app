import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/core/services/deep_linking_service.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';

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
  void initState() {
    super.initState();
    DeepLinkService.handleInitialLink(context);
    DeepLinkService.listenForLinks(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<HomeCubit>()..initHome())],
      child: MaterialApp.router(
        title: "Lawaen",
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: getApplicationTheme(),
        routerConfig: getIt<AppRouter>().config(),
      ),
    );
  }
}
