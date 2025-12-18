import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/offers/data/models/offer_model.dart';
import 'package:lawaen/features/offers/data/models/offer_type_model.dart';
import 'package:lawaen/features/offers/data/repos/offers_repo.dart';
import 'package:lawaen/features/offers/presentation/params/get_offers_params.dart';

part 'offers_state.dart';

@singleton
class OffersCubit extends Cubit<OffersState> {
  final OffersRepo _offersRepo;
  static const int _limit = 4;

  OffersCubit(this._offersRepo) : super(const OffersState());

  Set<String> selectedTypes = {};

  Future<void> getOfferTypes() async {
    emit(state.copyWith(offerTypesState: RequestState.loading, offerTypesError: null));

    final result = await _offersRepo.getOfferTypes();
    result.fold(
      (failure) {
        emit(state.copyWith(offerTypesState: RequestState.error, offerTypesError: failure.errorMessage));
      },
      (types) {
        emit(state.copyWith(offerTypesState: RequestState.success, offerTypes: types, offerTypesError: null));
      },
    );
  }

  Future<void> getOffersForSelectedTypes() async {
    if (selectedTypes.isEmpty) return;

    emit(
      state.copyWith(
        offersState: RequestState.loading,
        offers: [],
        currentPage: 1,
        hasMore: true,
        isLoadMore: false,
        offersError: null,
      ),
    );

    await _getOffers(isLoadMore: false);
  }

  Future<void> loadMoreOffers() async {
    if (!state.hasMore || state.isLoadMore) return;
    await _getOffers(isLoadMore: true);
  }

  Future<void> _getOffers({required bool isLoadMore}) async {
    if (isLoadMore) {
      emit(state.copyWith(isLoadMore: true));
    }

    final params = GetOffersParams(offerTypeIds: selectedTypes.toList(), page: state.currentPage, limit: _limit);

    final result = await _offersRepo.getOffers(params: params);

    result.fold(
      (failure) {
        emit(state.copyWith(offersState: RequestState.error, offersError: failure.errorMessage, isLoadMore: false));
      },
      (newOffers) {
        final updatedList = isLoadMore ? [...state.offers, ...newOffers] : newOffers;

        emit(
          state.copyWith(
            offersState: RequestState.success,
            offers: updatedList,
            offersError: null,
            isLoadMore: false,
            currentPage: newOffers.isEmpty ? state.currentPage : state.currentPage + 1,
            hasMore: newOffers.isNotEmpty,
          ),
        );
      },
    );
  }

  void updateSelectedTypes(Set<String> selected) {
    selectedTypes = selected;
    emit(state.copyWith());
  }
}
