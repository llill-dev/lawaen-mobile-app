part of 'offers_cubit.dart';

class OffersState extends Equatable {
  final RequestState offerTypesState;
  final List<OfferTypeModel> offerTypes;
  final String? offerTypesError;

  final RequestState offersState;
  final List<OfferModel> offers;
  final String? offersError;

  const OffersState({
    this.offerTypesState = RequestState.idle,
    this.offerTypes = const [],
    this.offerTypesError,
    this.offersState = RequestState.idle,
    this.offers = const [],
    this.offersError,
  });

  OffersState copyWith({
    RequestState? offerTypesState,
    List<OfferTypeModel>? offerTypes,
    String? offerTypesError,
    RequestState? offersState,
    List<OfferModel>? offers,
    String? offersError,
  }) {
    return OffersState(
      offerTypesState: offerTypesState ?? this.offerTypesState,
      offerTypes: offerTypes ?? this.offerTypes,
      offerTypesError: offerTypesError,
      offersState: offersState ?? this.offersState,
      offers: offers ?? this.offers,
      offersError: offersError,
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
      ];
}
