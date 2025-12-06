import 'dart:io' show File;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/params/offer_params.dart';

part 'add_offer_form_state.dart';

class AddOfferFormCubit extends Cubit<AddOfferFormState> {
  AddOfferFormCubit() : super(AddOfferFormState.initial());

  static const totalSteps = 3;

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

  void updateImage(File value) => emit(state.copyWith(params: state.params.copyWith(imageFile: value)));
}
