part of 'map_marker_cubit.dart';

class MapMarkerState extends Equatable {
  final bool isLoading;
  final String? error;

  final Map<String, BitmapDescriptor> markersGoogle;
  final Map<String, apple.BitmapDescriptor> markersApple;

  final BitmapDescriptor? fallbackGoogle;
  final apple.BitmapDescriptor? fallbackApple;

  const MapMarkerState({
    this.isLoading = false,
    this.error,
    this.markersGoogle = const {},
    this.markersApple = const {},
    this.fallbackGoogle,
    this.fallbackApple,
  });

  MapMarkerState copyWith({
    bool? isLoading,
    String? error,
    Map<String, BitmapDescriptor>? markersGoogle,
    Map<String, apple.BitmapDescriptor>? markersApple,
    BitmapDescriptor? fallbackGoogle,
    apple.BitmapDescriptor? fallbackApple,
  }) {
    return MapMarkerState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      markersGoogle: markersGoogle ?? this.markersGoogle,
      markersApple: markersApple ?? this.markersApple,
      fallbackGoogle: fallbackGoogle ?? this.fallbackGoogle,
      fallbackApple: fallbackApple ?? this.fallbackApple,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, markersGoogle, markersApple, fallbackGoogle, fallbackApple];
}
