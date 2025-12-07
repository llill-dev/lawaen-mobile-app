import 'dart:io' show File;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/add_to_app/data/repos/add_to_app_repo.dart';
import 'package:lawaen/features/add_to_app/data/models/add_offer_model.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_offer_params.dart';
import 'package:lawaen/features/add_to_app/presentation/validations/add_offer_validation.dart';

part 'add_offer_form_state.dart';

@injectable
class AddOfferFormCubit extends Cubit<AddOfferFormState> {
  final AddToAppRepo _addToAppRepo;

  AddOfferFormCubit(this._addToAppRepo) : super(AddOfferFormState.initial());

  static const totalSteps = 3;

  void updateRecaptcha(bool value) => emit(state.copyWith(params: state.params.copyWith(recaptcha: value)));

  Future<void> submit() async {
    emit(state.copyWith(submitState: RequestState.loading, submitError: null));

    final result = await _addToAppRepo.addOffer(state.params);
    result.fold(
      (failure) => emit(state.copyWith(submitState: RequestState.error, submitError: failure.errorMessage)),
      (offer) => emit(state.copyWith(submitState: RequestState.success, addedOffer: offer, submitError: null)),
    );
  }

  // ---------------- Validation -----------------
  bool validateStep(int step) {
    return validateAddOfferStep(state.params, step);
  }

  // ---------------- STEP NAVIGATION ----------------
  void nextStep() {
    if (state.currentStep < totalSteps - 1) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  // ---------------- FIELD UPDATES -------------------
  void updateName(String value) => emit(state.copyWith(params: state.params.copyWith(name: value)));

  void updateDescription(String value) => emit(state.copyWith(params: state.params.copyWith(description: value)));

  void updatePhone(String value) => emit(
    state.copyWith(
      params: state.params.copyWith(contact: state.params.contact.copyWith(phone: value)),
    ),
  );

  void updateWhatsapp(String value) => emit(
    state.copyWith(
      params: state.params.copyWith(contact: state.params.contact.copyWith(whatsapp: value)),
    ),
  );

  void updateImage(File value) => emit(state.copyWith(params: state.params.copyWith(imageFile: value)));

  void updateAcceptOne(bool value) => emit(
    state.copyWith(
      params: state.params.copyWith(acceptOptions: state.params.acceptOptions.copyWith(acceptOne: value)),
    ),
  );

  void updateAcceptTwo(bool value) => emit(
    state.copyWith(
      params: state.params.copyWith(acceptOptions: state.params.acceptOptions.copyWith(acceptTwo: value)),
    ),
  );

  void updateAcceptThree(bool value) => emit(
    state.copyWith(
      params: state.params.copyWith(acceptOptions: state.params.acceptOptions.copyWith(acceptThree: value)),
    ),
  );
}
