part of 'map_cubit.dart';

class MapState extends Equatable {
  final RequestState itemsState;
  final List<CategoryDetailsModel> items;
  final String? itemsError;

  final RequestState categoriesState;
  final List<CategoryModel> categories;
  final String? categoriesError;

  final double? userLatitude;
  final double? userLongitude;

  final String? selectedCategoryId;

  final bool isSheetExpanded;

  final String? globalError;

  final Map<String, BitmapDescriptor> googleCategoryMarkers;
  final Map<String, apple.BitmapDescriptor> appleCategoryMarkers;

  const MapState({
    this.itemsState = RequestState.idle,
    this.items = const [],
    this.itemsError,
    this.categoriesState = RequestState.idle,
    this.categories = const [],
    this.categoriesError,
    this.userLatitude,
    this.userLongitude,

    this.selectedCategoryId,
    this.isSheetExpanded = false,
    this.globalError,

    this.googleCategoryMarkers = const {},
    this.appleCategoryMarkers = const {},
  });

  MapState copyWith({
    RequestState? itemsState,
    List<CategoryDetailsModel>? items,
    String? itemsError,
    RequestState? categoriesState,
    List<CategoryModel>? categories,
    String? categoriesError,
    double? userLatitude,
    double? userLongitude,
    String? selectedCategoryId,
    bool? isSheetExpanded,
    String? globalError,
    Map<String, BitmapDescriptor>? googleCategoryMarkers,
    Map<String, apple.BitmapDescriptor>? appleCategoryMarkers,
  }) {
    return MapState(
      itemsState: itemsState ?? this.itemsState,
      items: items ?? this.items,
      itemsError: itemsError,
      categoriesState: categoriesState ?? this.categoriesState,
      categories: categories ?? this.categories,
      categoriesError: categoriesError,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,

      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      isSheetExpanded: isSheetExpanded ?? this.isSheetExpanded,
      globalError: globalError ?? this.globalError,

      googleCategoryMarkers: googleCategoryMarkers ?? this.googleCategoryMarkers,
      appleCategoryMarkers: appleCategoryMarkers ?? this.appleCategoryMarkers,
    );
  }

  @override
  List<Object?> get props => [
    itemsState,
    items,
    itemsError,
    categoriesState,
    categories,
    categoriesError,
    userLatitude,
    userLongitude,

    selectedCategoryId,
    isSheetExpanded,
    globalError,

    googleCategoryMarkers,
    appleCategoryMarkers,
  ];
}
