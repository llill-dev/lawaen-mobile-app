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

    final params = GetOffersParams(selectedTypes.toList());
    await getOffers(params: params);
  }

  Future<void> getOffers({required GetOffersParams params}) async {
    emit(state.copyWith(offersState: RequestState.loading, offersError: null));

    final result = await _offersRepo.getOffers(params: params);
    result.fold(
      (failure) {
        emit(state.copyWith(offersState: RequestState.error, offersError: failure.errorMessage));
      },
      (offers) {
        emit(state.copyWith(offersState: RequestState.success, offers: offers, offersError: null));
      },
    );
  }

  void updateSelectedTypes(Set<String> selected) {
    selectedTypes = selected;
    emit(state.copyWith());
  }
}
