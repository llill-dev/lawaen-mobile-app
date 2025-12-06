import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/params/missing_place_params.dart';

part 'add_missing_place_form_state.dart';

class AddMissingPlaceFormCubit extends Cubit<AddMissingPlaceFormState> {
  AddMissingPlaceFormCubit() : super(AddMissingPlaceFormState.initial());

  static const int totalSteps = 4;

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

  // ---------------- FIELD UPDATES -------------------

  void updateMainCategory(String value) =>
      emit(state.copyWith(params: state.params.copyWith(mainCategory: value)));

  void updateSubCategory(String value) =>
      emit(state.copyWith(params: state.params.copyWith(subCategory: value)));

  void updateName(String value) => emit(state.copyWith(params: state.params.copyWith(name: value)));

  void updateDescription(String value) =>
      emit(state.copyWith(params: state.params.copyWith(description: value)));

  void updatePhone(String value) => emit(
        state.copyWith(
          params: state.params.copyWith(
            contact: state.params.contact.copyWith(phone: value),
          ),
        ),
      );

  void updateWhatsapp(String value) => emit(
        state.copyWith(
          params: state.params.copyWith(
            contact: state.params.contact.copyWith(whatsapp: value),
          ),
        ),
      );

  void updateInstagram(String value) => emit(
        state.copyWith(
          params: state.params.copyWith(
            contact: state.params.contact.copyWith(instagram: value),
          ),
        ),
      );

  void updateFacebook(String value) => emit(
        state.copyWith(
          params: state.params.copyWith(
            contact: state.params.contact.copyWith(facebook: value),
          ),
        ),
      );

  void updateStartTime(String value) =>
      emit(state.copyWith(params: state.params.copyWith(startTime: value)));

  void updateEndTime(String value) =>
      emit(state.copyWith(params: state.params.copyWith(endTime: value)));

  void updateImage(File value) => emit(state.copyWith(params: state.params.copyWith(imageFile: value)));

  void updateLocation(double latitude, double longitude) => emit(
        state.copyWith(
          params: state.params.copyWith(
            location: state.params.location.copyWith(lat: latitude, lng: longitude),
          ),
        ),
      );

  void updateAcceptOne(bool value) => emit(
        state.copyWith(
          params: state.params.copyWith(
            acceptOptions: state.params.acceptOptions.copyWith(acceptOne: value),
          ),
        ),
      );

  void updateAcceptTwo(bool value) => emit(
        state.copyWith(
          params: state.params.copyWith(
            acceptOptions: state.params.acceptOptions.copyWith(acceptTwo: value),
          ),
        ),
      );

  void updateAcceptThree(bool value) => emit(
        state.copyWith(
          params: state.params.copyWith(
            acceptOptions: state.params.acceptOptions.copyWith(acceptThree: value),
          ),
        ),
      );
}
