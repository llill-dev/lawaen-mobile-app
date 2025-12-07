import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/add_to_app/data/models/add_missing_plcae_model.dart';
import 'package:lawaen/features/add_to_app/data/repos/add_to_app_repo.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_missing_place_params.dart';
import 'package:lawaen/features/add_to_app/presentation/validations/add_missing_place_validation.dart';

part 'add_missing_place_form_state.dart';

@injectable
class AddMissingPlaceFormCubit extends Cubit<AddMissingPlaceFormState> {
  final AddToAppRepo _addToAppRepo;

  AddMissingPlaceFormCubit(this._addToAppRepo) : super(AddMissingPlaceFormState.initial());

  static const int totalSteps = 4;

  Future<void> submit() async {
    emit(state.copyWith(submitState: RequestState.loading, submitError: null));

    final result = await _addToAppRepo.addMissingPlace(state.params);
    result.fold(
      (failure) => emit(state.copyWith(submitState: RequestState.error, submitError: failure.errorMessage)),
      (place) => emit(state.copyWith(submitState: RequestState.success, addedPlace: place, submitError: null)),
    );
  }

  // ---------------- STEP NAVIGATION -----------------

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

  void jumpTo(int index) {
    if (index >= 0 && index < totalSteps) {
      emit(state.copyWith(currentStep: index));
    }
  }

  // ---------------- Validation -----------------
  bool validateStep(int step) {
    return validateAddMissingPlaceStep(state.params, step);
  }

  // ---------------- FIELD UPDATES -------------------

  void updateMainCategory(String value) => emit(state.copyWith(params: state.params.copyWith(mainCategory: value)));

  void updateSubCategory(String? value) => emit(state.copyWith(params: state.params.copyWith(subCategory: value)));

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

  void updateInstagram(String value) => emit(
    state.copyWith(
      params: state.params.copyWith(contact: state.params.contact.copyWith(instagram: value)),
    ),
  );

  void updateFacebook(String value) => emit(
    state.copyWith(
      params: state.params.copyWith(contact: state.params.contact.copyWith(facebook: value)),
    ),
  );

  void updateOpenTime(String value) => emit(state.copyWith(params: state.params.copyWith(openTime: value)));

  void updateCloseTime(String value) => emit(state.copyWith(params: state.params.copyWith(closeTime: value)));

  void updateLocation(double latitude, double longitude) => emit(
    state.copyWith(
      params: state.params.copyWith(
        location: state.params.location.copyWith(lat: latitude, lng: longitude),
      ),
    ),
  );

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

  void updateImage(File value) => emit(state.copyWith(params: state.params.copyWith(imageFile: value)));

  void updateRecaptcha(bool value) => emit(state.copyWith(params: state.params.copyWith(recaptcha: value)));
}
