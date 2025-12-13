part of 'explore_cubit.dart';

class ExploreState extends Equatable {
  final RequestState exploreState;
  final List<CategoryDetailsModel> exploreItems;
  final String? exploreError;
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
        globalError,
        isLoadMore,
        currentPage,
        limit,
        hasMore,
        search,
      ];
}
