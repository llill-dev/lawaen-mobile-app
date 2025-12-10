import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/features/nearby/presentation/cubit/map_cubit.dart';
import 'package:lawaen/features/nearby/presentation/views/widgets/map_bottom_sheet.dart';
import 'package:lawaen/features/nearby/presentation/views/widgets/platform_map_widget.dart';

@RoutePage()
class NearbyMapScreen extends StatefulWidget {
  const NearbyMapScreen({super.key});

  @override
  State<NearbyMapScreen> createState() => _NearbyMapScreenState();
}

class _NearbyMapScreenState extends State<NearbyMapScreen> {
  late final MapCubit _mapCubit;
  late final double lat;
  late final double long;

  @override
  void initState() {
    super.initState();
    final userLocation = getIt<LocationService>().getLocationFromPrefs();
    lat = userLocation?.latitude ?? 33.5133;
    long = userLocation?.longitude ?? 36.27646;
    _mapCubit = getIt<MapCubit>();
    //_mapCubit.initMap();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _mapCubit,
      child: Scaffold(
        body: BlocConsumer<MapCubit, MapState>(
          listener: (context, state) {
            if (state.itemsState == RequestState.error || state.globalError != null) {
              showToast(message: state.globalError!);
            }
          },
          builder: (context, state) {
            return SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  PlatformMapWidget(latitude: lat, longitude: long, items: state.items),
                  Positioned(top: 10, left: 10, child: PrimaryBackButton(iconOnlay: true, iconSize: 20, width: 50)),
                  const MapBottomSheet(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
