import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_offer_form_state.dart';

class AddOfferFormCubit extends Cubit<AddOfferFormState> {
  AddOfferFormCubit()
    : super(const AddOfferFormState(currentStep: 0, name: '', description: '', phone: '', whatsapp: ''));

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
  void updateName(String value) => emit(state.copyWith(name: value));
  void updateDescription(String value) => emit(state.copyWith(description: value));
  void updatePhone(String value) => emit(state.copyWith(phone: value));
  void updateWhatsapp(String value) => emit(state.copyWith(whatsapp: value));
}
