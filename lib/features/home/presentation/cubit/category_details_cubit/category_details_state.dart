part of 'category_details_cubit.dart';

enum RequestState { idle, loading, success, error }

class CategoryDetailsState extends Equatable {
  final RequestState categoryDetailsState;
  final List<CategoryDetailsModel> categories;
  final String? categoriesError;
  final String? globalError;
  final int categoriesCurrentPage;
  final int limit;
  final bool hasMore;
  final bool isLoadingMore;

  final String? selectedSecondCategoryId;

  const CategoryDetailsState({
    this.categoryDetailsState = RequestState.idle,
    this.categories = const [],
    this.categoriesError,
    this.globalError,
    this.categoriesCurrentPage = 1,
    this.limit = 10,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.selectedSecondCategoryId,
  });

  CategoryDetailsState copyWith({
    RequestState? categoryDetailsState,
    List<CategoryDetailsModel>? categories,
    String? categoriesError,
    String? globalError,
    int? categoriesCurrentPage,
    int? limit,
    bool? hasMore,
    bool? isLoadingMore,

    bool resetSelectedSecondCategoryId = false,
    String? selectedSecondCategoryId,
  }) {
    return CategoryDetailsState(
      categoryDetailsState: categoryDetailsState ?? this.categoryDetailsState,
      categories: categories ?? this.categories,
      categoriesError: categoriesError,
      globalError: globalError,
      categoriesCurrentPage: categoriesCurrentPage ?? this.categoriesCurrentPage,
      limit: limit ?? this.limit,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,

      selectedSecondCategoryId: resetSelectedSecondCategoryId
          ? null
          : (selectedSecondCategoryId ?? this.selectedSecondCategoryId),
    );
  }

  @override
  List<Object?> get props => [
    categoryDetailsState,
    categories,
    categoriesError,
    globalError,
    categoriesCurrentPage,
    limit,
    hasMore,
    isLoadingMore,
    selectedSecondCategoryId,
  ];
}
