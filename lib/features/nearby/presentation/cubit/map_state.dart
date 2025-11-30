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

  final String searchQuery;
  final String? selectedCategoryId;

  final bool isSheetExpanded;

  const MapState({
    this.itemsState = RequestState.idle,
    this.items = const [],
    this.itemsError,
    this.categoriesState = RequestState.idle,
    this.categories = const [],
    this.categoriesError,
    this.userLatitude,
    this.userLongitude,
    this.searchQuery = '',
    this.selectedCategoryId,
    this.isSheetExpanded = false,
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
    String? searchQuery,
    String? selectedCategoryId,
    bool? isSheetExpanded,
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
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      isSheetExpanded: isSheetExpanded ?? this.isSheetExpanded,
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
    searchQuery,
    selectedCategoryId,
    isSheetExpanded,
  ];
}
