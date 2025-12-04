import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/error_view.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/core/widgets/primary_back_button.dart';
import 'package:lawaen/app/di/injection.dart';
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

  @override
  void initState() {
    super.initState();
    _mapCubit = getIt<MapCubit>();
    _mapCubit.initMap();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _mapCubit,
      child: Scaffold(
        body: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            if (state.itemsState == RequestState.loading && state.items.isEmpty) {
              return const LoadingWidget();
            }

            if (state.itemsState == RequestState.error) {
              return Center(
                child: ErrorView(errorMsg: state.globalError, onRetry: () => _mapCubit.initMap(), withBackButton: true),
              );
            }

            return SafeArea(
              child: Stack(
                children: [
                  PlatformMapWidget(latitude: state.userLatitude, longitude: state.userLongitude, items: state.items),
                  Positioned(top: 10, left: 10, child: PrimaryBackButton(iconOnlay: true, iconSize: 20)),
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
