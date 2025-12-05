import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_event_form_state.dart';

class AddEventFormCubit extends Cubit<AddEventFormState> {
  AddEventFormCubit()
    : super(
        const AddEventFormState(
          currentStep: 0,
          // strings empty by default
          name: '',
          eventType: '',
          description: '',
          phone: '',
          whatsapp: '',
          instagram: '',
          facebook: '',
          bookingMethod: '',
          price: '',
          bookingFee: '',
          organiserLink: '',
        ),
      );

  // ---- STEP NAVIGATION ----
  static const int totalSteps = 5;

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

  void jumpToStep(int index) {
    if (index >= 0 && index < totalSteps) {
      emit(state.copyWith(currentStep: index));
    }
  }

  // ---- FIELD UPDATERS ----
  void updateName(String value) => emit(state.copyWith(name: value));
  void updateEventType(String value) => emit(state.copyWith(eventType: value));
  void updateDescription(String value) => emit(state.copyWith(description: value));

  void updatePhone(String value) => emit(state.copyWith(phone: value));
  void updateWhatsapp(String value) => emit(state.copyWith(whatsapp: value));
  void updateInstagram(String value) => emit(state.copyWith(instagram: value));
  void updateFacebook(String value) => emit(state.copyWith(facebook: value));

  void updateBookingMethod(String value) => emit(state.copyWith(bookingMethod: value));
  void updatePrice(String value) => emit(state.copyWith(price: value));
  void updateBookingFee(String value) => emit(state.copyWith(bookingFee: value));
  void updateOrganiserLink(String value) => emit(state.copyWith(organiserLink: value));

  void updateStartTime(TimeOfDay value) => emit(state.copyWith(startTime: value));
  void updateEndTime(TimeOfDay value) => emit(state.copyWith(endTime: value));

  void updateStartDate(DateTime value) => emit(state.copyWith(startDate: value));
  void updateEndDate(DateTime value) => emit(state.copyWith(endDate: value));

  // Event time (like a single DateTime or text)
  void updateEventTime(String value) => emit(state.copyWith(eventTime: value));

  // later: add image, location, etc.
}
