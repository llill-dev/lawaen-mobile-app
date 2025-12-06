import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/params/event_params.dart';

part 'add_event_form_state.dart';

class AddEventFormCubit extends Cubit<AddEventFormState> {
  static const int totalSteps = 5;

  AddEventFormCubit() : super(AddEventFormState.initial());

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

  // Basic info
  void updateEventType(String value) => emit(state.copyWith(params: state.params.copyWith(eventType: value)));

  void updateName(String value) => emit(state.copyWith(params: state.params.copyWith(name: value)));

  void updateDescription(String value) => emit(state.copyWith(params: state.params.copyWith(description: value)));

  // Contact
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

  // Booking
  void updateBookingMethod(String value) => emit(state.copyWith(params: state.params.copyWith(bookingMethod: value)));

  void updatePrice(String value) => emit(state.copyWith(params: state.params.copyWith(price: value)));

  void updateBookingFee(String value) => emit(state.copyWith(params: state.params.copyWith(bookingFee: value)));

  void updateOrganiserLink(String value) => emit(state.copyWith(params: state.params.copyWith(organiserLink: value)));

  // Time & dates (strings)
  void updateStartTime(String value) => emit(state.copyWith(params: state.params.copyWith(startTime: value)));

  void updateEndTime(String value) => emit(state.copyWith(params: state.params.copyWith(endTime: value)));

  void updateStartDate(String value) => emit(state.copyWith(params: state.params.copyWith(startDate: value)));

  void updateEndDate(String value) => emit(state.copyWith(params: state.params.copyWith(endDate: value)));

  void updateEventTime(String value) => emit(state.copyWith(params: state.params.copyWith(eventTime: value)));

  // Location
  void updateLocation(double lat, double lng) => emit(
    state.copyWith(
      params: state.params.copyWith(
        location: state.params.location.copyWith(lat: lat, lng: lng),
      ),
    ),
  );

  // Image
  void updateImage(File file) => emit(state.copyWith(params: state.params.copyWith(imageFile: file)));

  // Accept options
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
