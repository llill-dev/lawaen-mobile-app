import 'dart:io' show File;

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/add_to_app/data/repos/add_to_app_repo.dart';
import 'package:lawaen/features/add_to_app/data/models/add_offer_model.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_offer_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

part 'add_offer_form_state.dart';

@injectable
class AddOfferFormCubit extends Cubit<AddOfferFormState> {
  final AddToAppRepo _addToAppRepo;

  AddOfferFormCubit(this._addToAppRepo) : super(AddOfferFormState.initial());

  static const totalSteps = 3;

  void updateRecaptcha(bool value) => emit(state.copyWith(params: state.params.copyWith(recaptcha: value)));

  Future<void> submit() async {
    emit(state.copyWith(submitState: RequestState.loading, submitError: null));

    final result = await _addToAppRepo.addOffer(state.params);
    result.fold(
      (failure) => emit(state.copyWith(submitState: RequestState.error, submitError: failure.errorMessage)),
      (offer) => emit(state.copyWith(submitState: RequestState.success, addedOffer: offer, submitError: null)),
    );
  }

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

  void updateImage(File value) => emit(state.copyWith(params: state.params.copyWith(imageFile: value)));

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

  bool validateStep(int step) {
    final p = state.params;

    switch (step) {
      // -------------------------------
      // STEP 0 → Basic Info
      // -------------------------------
      case 0:
        if (p.name == null || p.name!.trim().isEmpty) {
          showToast(message: LocaleKeys.nameRequired.tr(), isError: true);
          return false;
        }
        if (p.description == null || p.description!.trim().isEmpty) {
          showToast(message: LocaleKeys.descriptionRequired.tr(), isError: true);
          return false;
        }
        return true;

      // -------------------------------
      // STEP 1 → Contact Info
      // -------------------------------
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

        return true;

      case 2:
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
}
