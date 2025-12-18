part of 'offers_cubit.dart';

class OffersState extends Equatable {
  final RequestState offerTypesState;
  final List<OfferTypeModel> offerTypes;
  final String? offerTypesError;

  final RequestState offersState;
  final List<OfferModel> offers;
  final String? offersError;

  // pagination
  final int currentPage;
  final bool hasMore;
  final bool isLoadMore;

  const OffersState({
    this.offerTypesState = RequestState.idle,
    this.offerTypes = const [],
    this.offerTypesError,
    this.offersState = RequestState.idle,
    this.offers = const [],
    this.offersError,

    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadMore = false,
  });

  OffersState copyWith({
    RequestState? offerTypesState,
    List<OfferTypeModel>? offerTypes,
    String? offerTypesError,
    RequestState? offersState,
    List<OfferModel>? offers,
    String? offersError,
    int? currentPage,
    bool? hasMore,
    bool? isLoadMore,
  }) {
    return OffersState(
      offerTypesState: offerTypesState ?? this.offerTypesState,
      offerTypes: offerTypes ?? this.offerTypes,
      offerTypesError: offerTypesError,
      offersState: offersState ?? this.offersState,
      offers: offers ?? this.offers,
      offersError: offersError,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }

  @override
  List<Object?> get props => [
    offerTypesState,
    offerTypes,
    offerTypesError,
    offersState,
    offers,
    offersError,
    currentPage,
    hasMore,
    isLoadMore,
  ];
}
