part of 'category_item_detials_cubit.dart';

class CategoryItemDetialsState extends Equatable {
  final RequestState categoryItemState;
  final ItemData? categoryItems;
  final String? categoryItemsError;

  final RequestState toggleFavoriteState;
  final String? toggleFavoriteError;
  final bool saved;

  final String? globalError;

  const CategoryItemDetialsState({
    this.categoryItemState = RequestState.idle,
    this.categoryItems,
    this.categoryItemsError,
    this.toggleFavoriteState = RequestState.idle,
    this.saved = false,
    this.toggleFavoriteError,
    this.globalError,
  });

  CategoryItemDetialsState copyWith({
    RequestState? categoryItemState,
    ItemData? categoryItems,
    String? categoryItemsError,

    RequestState? toggleFavoriteState,
    bool? saved,
    String? toggleFavoriteError,

    String? globalError,
  }) {
    return CategoryItemDetialsState(
      categoryItemState: categoryItemState ?? this.categoryItemState,
      categoryItems: categoryItems ?? this.categoryItems,
      categoryItemsError: categoryItemsError ?? this.categoryItemsError,
      saved: saved ?? this.saved,
      toggleFavoriteState: toggleFavoriteState ?? this.toggleFavoriteState,
      toggleFavoriteError: toggleFavoriteError ?? this.toggleFavoriteError,
      globalError: globalError ?? this.globalError,
    );
  }

  @override
  List<Object?> get props => [
    categoryItemState,
    categoryItems,
    categoryItemsError,
    toggleFavoriteError,
    toggleFavoriteState,
    saved,
    globalError,
  ];
}
