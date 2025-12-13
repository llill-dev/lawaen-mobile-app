part of 'explore_cubit.dart';

class ExploreState extends Equatable {
  final RequestState exploreState;
  final List<CategoryDetailsModel> exploreItems;
  final String? exploreError;
  final RequestState preferencesState;
  final List<UserPreferencesModel> userPreferences;
  final String? preferencesError;
  final String? globalError;
  final bool isLoadMore;
  final int currentPage;
  final int limit;
  final bool hasMore;
  final String? search;

  const ExploreState({
    this.exploreState = RequestState.idle,
    this.exploreItems = const [],
    this.exploreError,
    this.preferencesState = RequestState.idle,
    this.userPreferences = const [],
    this.preferencesError,
    this.globalError,
    this.isLoadMore = false,
    this.currentPage = 1,
    this.limit = 10,
    this.hasMore = true,
    this.search,
  });

  ExploreState copyWith({
    RequestState? exploreState,
    List<CategoryDetailsModel>? exploreItems,
    String? exploreError,
    RequestState? preferencesState,
    List<UserPreferencesModel>? userPreferences,
    String? preferencesError,
    String? globalError,
    bool? isLoadMore,
    int? currentPage,
    int? limit,
    bool? hasMore,
    String? search,
  }) {
    return ExploreState(
      exploreState: exploreState ?? this.exploreState,
      exploreItems: exploreItems ?? this.exploreItems,
      exploreError: exploreError,
      preferencesState: preferencesState ?? this.preferencesState,
      userPreferences: userPreferences ?? this.userPreferences,
      preferencesError: preferencesError,
      globalError: globalError,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      currentPage: currentPage ?? this.currentPage,
      limit: limit ?? this.limit,
      hasMore: hasMore ?? this.hasMore,
      search: search ?? this.search,
    );
  }

  @override
  List<Object?> get props => [
        exploreState,
        exploreItems,
        exploreError,
        preferencesState,
        userPreferences,
        preferencesError,
        globalError,
        isLoadMore,
        currentPage,
        limit,
        hasMore,
        search,
      ];
}
