part of 'explore_cubit.dart';

class ExploreState extends Equatable {
  final RequestState exploreState;
  final List<CategoryDetailsModel> exploreItems;
  final String? exploreError;
  final String? selectedCategoryId;

  final RequestState preferencesState;
  final List<UserPreferencesModel> userPreferences;
  final String? preferencesError;
  final bool isLoadMore;
  final int currentPage;
  final int limit;
  final bool hasMore;
  final String? search;

  final List<String> recentSearches;

  final String? globalError;

  const ExploreState({
    this.exploreState = RequestState.idle,
    this.exploreItems = const [],
    this.exploreError,
    this.selectedCategoryId,
    this.preferencesState = RequestState.idle,
    this.userPreferences = const [],
    this.preferencesError,
    this.globalError,
    this.isLoadMore = false,
    this.currentPage = 1,
    this.limit = 10,
    this.hasMore = true,
    this.search,
    this.recentSearches = const [],
  });

  ExploreState copyWith({
    RequestState? exploreState,
    List<CategoryDetailsModel>? exploreItems,
    String? exploreError,
    String? selectedCategoryId,
    RequestState? preferencesState,
    List<UserPreferencesModel>? userPreferences,
    String? preferencesError,
    String? globalError,
    bool? isLoadMore,
    int? currentPage,
    int? limit,
    bool? hasMore,
    String? search,
    List<String>? recentSearches,
  }) {
    return ExploreState(
      exploreState: exploreState ?? this.exploreState,
      exploreItems: exploreItems ?? this.exploreItems,
      exploreError: exploreError,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      preferencesState: preferencesState ?? this.preferencesState,
      userPreferences: userPreferences ?? this.userPreferences,
      preferencesError: preferencesError,
      globalError: globalError,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      currentPage: currentPage ?? this.currentPage,
      limit: limit ?? this.limit,
      hasMore: hasMore ?? this.hasMore,

      recentSearches: recentSearches ?? this.recentSearches,

      search: search ?? this.search,
    );
  }

  @override
  List<Object?> get props => [
    exploreState,
    exploreItems,
    exploreError,
    selectedCategoryId,
    preferencesState,
    userPreferences,
    preferencesError,
    globalError,
    isLoadMore,
    currentPage,
    limit,
    hasMore,
    search,
    recentSearches,
  ];
}
