import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_event_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

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

  bool validateStep(int step) {
    final p = state.params;

    switch (step) {
      case 0:
        if (p.name == null || p.name!.trim().isEmpty) {
          showToast(message: LocaleKeys.nameRequired.tr(), isError: true);
          return false;
        }
        return true;

      case 1:
        final phone = p.contact.phone?.trim() ?? "";
        final whatsapp = p.contact.whatsapp?.trim() ?? "";
        final instagram = p.contact.instagram?.trim() ?? "";
        final facebook = p.contact.facebook?.trim() ?? "";

        if (phone.isNotEmpty && !RegExp(r'^\d+$').hasMatch(phone)) {
          showToast(message: LocaleKeys.phoneMustBeNumeric.tr(), isError: true);
          return false;
        }

        if (whatsapp.isNotEmpty && !RegExp(r'^\d+$').hasMatch(whatsapp)) {
          showToast(message: LocaleKeys.whatsappMustBeNumeric.tr(), isError: true);
          return false;
        }

        if (instagram.isNotEmpty && !instagram.startsWith("http")) {
          showToast(message: LocaleKeys.instagramMustBeValidUrl.tr(), isError: true);
          return false;
        }

        if (facebook.isNotEmpty && !facebook.startsWith("http")) {
          showToast(message: LocaleKeys.facebookMustBeValidUrl.tr(), isError: true);
          return false;
        }

        return true;

      case 2:
        if (p.price != null && p.price!.isNotEmpty && !RegExp(r'^\d+(\.\d+)?$').hasMatch(p.price!)) {
          showToast(message: LocaleKeys.priceMustBeNumber.tr(), isError: true);
          return false;
        }

        return true;

      case 3:
        if (p.location.lat == null || p.location.lng == null) {
          showToast(message: LocaleKeys.locationIsRequired.tr(), isError: true);
          return false;
        }
        return true;

      case 4:
        if (p.startTime == null || p.startTime!.isEmpty) {
          showToast(message: LocaleKeys.startTimeIsRequired.tr(), isError: true);
          return false;
        }

        if (p.endTime == null || p.endTime!.isEmpty) {
          showToast(message: LocaleKeys.endTimeIsRequired.tr(), isError: true);
          return false;
        }

        final start = _parseTime(p.startTime!);
        final end = _parseTime(p.endTime!);

        if (start != null && end != null && !_isTimeBefore(start, end)) {
          showToast(message: LocaleKeys.startTimeMustBeBeforeEndTime.tr(), isError: true);
          return false;
        }

        if (p.startEventDate != null && p.endEventDate != null) {
          final startD = DateTime.tryParse(p.startEventDate!);
          final endD = DateTime.tryParse(p.endEventDate!);

          if (startD != null && endD != null && startD.isAfter(endD)) {
            showToast(message: LocaleKeys.startEventDateMustBeBeforeEndEventDate.tr(), isError: true);
            return false;
          }
        }

        if (p.eventTime != null && DateTime.tryParse(p.eventTime!) == null) {
          showToast(message: LocaleKeys.eventTimeMustBeValidDate.tr(), isError: true);
          return false;
        }

        if (p.note != null && p.note!.trim().isNotEmpty && p.note!.trim().length < 10) {
          showToast(message: LocaleKeys.noteMustBeAtLeast10Chars.tr(), isError: true);
          return false;
        }

        return true;

      default:
        return true;
    }
  }

  TimeOfDay? _parseTime(String input) {
    final parts = input.split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return TimeOfDay(hour: h, minute: m);
  }

  bool _isTimeBefore(TimeOfDay a, TimeOfDay b) {
    if (a.hour < b.hour) return true;
    if (a.hour == b.hour && a.minute < b.minute) return true;
    return false;
  }
}
