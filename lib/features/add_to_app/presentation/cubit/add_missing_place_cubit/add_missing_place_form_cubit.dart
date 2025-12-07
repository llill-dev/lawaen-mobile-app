import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_missing_place_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

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

  bool validateStep(int step) {
    final p = state.params;

    switch (step) {
      case 0:
        if (p.name == null || p.name!.trim().isEmpty) {
          showToast(message: LocaleKeys.nameRequired.tr(), isError: true);
          return false;
        }
        if (p.mainCategory == null || p.mainCategory!.isEmpty) {
          showToast(message: LocaleKeys.mainCategoryRequired.tr(), isError: true);
          return false;
        }
        if (p.subCategory == null || p.subCategory!.isEmpty) {
          showToast(message: LocaleKeys.subCategoryRequired.tr(), isError: true);
          return false;
        }
        if (p.description == null || p.description!.trim().isEmpty) {
          showToast(message: LocaleKeys.descriptionRequired.tr(), isError: true);
          return false;
        }
        return true;

      case 1:
        final phone = p.contact.phone?.trim() ?? "";
        if (phone.isEmpty) {
          showToast(message: LocaleKeys.phoneRequired.tr(), isError: true);
          return false;
        }
        if (!RegExp(r'^\d+$').hasMatch(phone)) {
          showToast(message: LocaleKeys.phoneMustBeNumeric.tr(), isError: true);
          return false;
        }

        final whatsapp = p.contact.whatsapp?.trim() ?? "";
        if (whatsapp.isNotEmpty && !RegExp(r'^\d+$').hasMatch(whatsapp)) {
          showToast(message: LocaleKeys.whatsappMustBeNumeric.tr(), isError: true);
          return false;
        }

        final insta = p.contact.instagram?.trim() ?? "";
        final facebook = p.contact.facebook?.trim() ?? "";

        if (insta.isNotEmpty && !insta.startsWith("http")) {
          showToast(message: LocaleKeys.instagramMustBeValidUrl.tr(), isError: true);
          return false;
        }
        if (facebook.isNotEmpty && !facebook.startsWith("http")) {
          showToast(message: LocaleKeys.facebookMustBeValidUrl.tr(), isError: true);
          return false;
        }

        return true;

      case 2:
        if (p.location.lat == null || p.location.lng == null) {
          showToast(message: LocaleKeys.locationIsRequired.tr(), isError: true);
          return false;
        }
        return true;

      case 3:
        if (p.openTime != null && p.openTime!.isNotEmpty && p.closeTime != null && p.closeTime!.isNotEmpty) {
          final open = _parseTime(p.openTime!);
          final close = _parseTime(p.closeTime!);
          if (open != null && close != null && !_isTimeBefore(open, close)) {
            showToast(message: LocaleKeys.openTimeMustBeBeforeCloseTime.tr(), isError: true);
            return false;
          }
        }

        if (!(p.acceptOptions.acceptOne ?? false)) {
          showToast(message: LocaleKeys.youMustAcceptTheTerms.tr(), isError: true);
          return false;
        }
        if (!(p.acceptOptions.acceptTwo ?? false)) {
          showToast(message: LocaleKeys.youMustReviewSubscriptionCost.tr(), isError: true);
          return false;
        }
        if (!(p.acceptOptions.acceptThree ?? false)) {
          showToast(message: LocaleKeys.youMustConfirmInformationAccuracy.tr(), isError: true);
          return false;
        }

        if (!p.recaptcha) {
          showToast(message: LocaleKeys.verifyYouAreNotRobot.tr(), isError: true);
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
