part of 'category_item_detials_cubit.dart';

class CategoryItemDetialsState extends Equatable {
  final RequestState categoryItemState;
  final ItemData? categoryItems;
  final String? categoryItemsError;
  final String? globalError;

  const CategoryItemDetialsState({
    this.categoryItemState = RequestState.idle,
    this.categoryItems,
    this.categoryItemsError,
    this.globalError,
  });

  CategoryItemDetialsState copyWith({
    RequestState? categoryItemState,
    ItemData? categoryItems,
    String? categoryItemsError,

    String? globalError,
  }) {
    return CategoryItemDetialsState(
      categoryItemState: categoryItemState ?? this.categoryItemState,
      categoryItems: categoryItems ?? this.categoryItems,
      categoryItemsError: categoryItemsError ?? this.categoryItemsError,
      globalError: globalError ?? this.globalError,
    );
  }

  @override
  List<Object?> get props => [categoryItemState, categoryItems, categoryItemsError, globalError];
}
