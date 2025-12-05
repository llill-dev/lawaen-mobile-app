import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_missing_place_form_state.dart';

class AddMissingPlaceFormCubit extends Cubit<AddMissingPlaceFormState> {
  AddMissingPlaceFormCubit()
    : super(
        const AddMissingPlaceFormState(
          currentStep: 0,
          mainCategory: '',
          subCategory: '',
          name: '',
          description: '',
          phone: '',
          whatsapp: '',
          instagram: '',
          facebook: '',
        ),
      );

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

  void updateMainCategory(String value) => emit(state.copyWith(mainCategory: value));
  void updateSubCategory(String value) => emit(state.copyWith(subCategory: value));

  void updateName(String value) => emit(state.copyWith(name: value));
  void updateDescription(String value) => emit(state.copyWith(description: value));

  void updatePhone(String value) => emit(state.copyWith(phone: value));
  void updateWhatsapp(String value) => emit(state.copyWith(whatsapp: value));
  void updateInstagram(String value) => emit(state.copyWith(instagram: value));
  void updateFacebook(String value) => emit(state.copyWith(facebook: value));

  void updateStartTime(TimeOfDay value) => emit(state.copyWith(startTime: value));
  void updateEndTime(TimeOfDay value) => emit(state.copyWith(endTime: value));
}
