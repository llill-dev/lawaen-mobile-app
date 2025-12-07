import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/add_to_app/data/models/add_event_model.dart';
import 'package:lawaen/features/add_to_app/data/repos/add_to_app_repo.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_event_params.dart';
import 'package:lawaen/features/add_to_app/presentation/validations/add_event_validation.dart';

part 'add_event_form_state.dart';

@injectable
class AddEventFormCubit extends Cubit<AddEventFormState> {
  final AddToAppRepo _addToAppRepo;
  static const int totalSteps = 5;

  AddEventFormCubit(this._addToAppRepo) : super(AddEventFormState.initial());

  Future<void> submit() async {
    emit(state.copyWith(submitState: RequestState.loading, submitError: null));

    final result = await _addToAppRepo.addEvent(state.params);

    result.fold(
      (failure) => emit(state.copyWith(submitState: RequestState.error, submitError: failure.errorMessage)),
      (event) => emit(state.copyWith(submitState: RequestState.success, addedEvent: event, submitError: null)),
    );
  }

  // ---------------- Validation -----------------

  bool validateStep(int step) {
    return validateAddEventStep(state.params, step);
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

  void jumpToStep(int index) {
    if (index >= 0 && index < totalSteps) {
      emit(state.copyWith(currentStep: index));
    }
  }

  // ---------------- FIELD UPDATES -------------------

  void updateEventType(String value) => emit(state.copyWith(params: state.params.copyWith(eventType: value)));

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

  void updateBookingMethod(String value) => emit(state.copyWith(params: state.params.copyWith(bookingMethod: value)));

  void updatePrice(String value) => emit(state.copyWith(params: state.params.copyWith(price: value)));

  void updateOrganization(String value) => emit(state.copyWith(params: state.params.copyWith(organization: value)));

  void updateStartTime(String value) => emit(state.copyWith(params: state.params.copyWith(startTime: value)));

  void updateEndTime(String value) => emit(state.copyWith(params: state.params.copyWith(endTime: value)));

  void updateStartDate(String value) => emit(state.copyWith(params: state.params.copyWith(startDate: value)));

  void updateEndDate(String value) => emit(state.copyWith(params: state.params.copyWith(endDate: value)));

  void updateStartEventDate(String value) => emit(state.copyWith(params: state.params.copyWith(startEventDate: value)));

  void updateEndEventDate(String value) => emit(state.copyWith(params: state.params.copyWith(endEventDate: value)));

  void updateEventTime(String value) => emit(state.copyWith(params: state.params.copyWith(eventTime: value)));

  void updateNote(String value) => emit(state.copyWith(params: state.params.copyWith(note: value)));

  void updateLocation(double lat, double lng) => emit(
    state.copyWith(
      params: state.params.copyWith(
        location: state.params.location.copyWith(lat: lat, lng: lng),
      ),
    ),
  );

  void updateImage(File file) => emit(state.copyWith(params: state.params.copyWith(imageFile: file)));
}
