import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/core/services/deep_linking_service.dart';
import 'package:lawaen/features/events/presentation/cubit/event_cubit/event_cubit.dart';
import 'package:lawaen/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:lawaen/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:lawaen/features/home/presentation/cubit/messages_cubit/messages_cubit.dart';
import 'package:lawaen/features/home/presentation/cubit/mune_cubit/mune_cubit.dart';
import 'package:lawaen/features/nearby/presentation/cubit/map_marker/map_marker_cubit.dart';
import 'package:lawaen/features/offers/presentation/cubit/offers_cubit/offers_cubit.dart';
import 'package:lawaen/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';

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
      providers: [
        BlocProvider(create: (context) => getIt<MapMarkerCubit>()),
        BlocProvider(create: (context) => getIt<HomeCubit>()..initHome()),
        BlocProvider(create: (context) => getIt<EventCubit>()),
        BlocProvider(create: (context) => getIt<OffersCubit>()),
        BlocProvider(create: (context) => getIt<MuneCubit>()),
        BlocProvider(create: (context) => getIt<ExploreCubit>()),
        BlocProvider(create: (context) => getIt<ProfileCubit>()),
        BlocProvider(create: (context) => getIt<MessagesCubit>()),
      ],
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
