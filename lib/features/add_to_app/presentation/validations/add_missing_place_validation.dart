import 'package:easy_localization/easy_localization.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_missing_place_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

bool validateAddMissingPlaceStep(AddMissingPlaceParams params, int step) {
  switch (step) {
    case 0:
      if (params.name == null || params.name!.trim().isEmpty) {
        showToast(message: LocaleKeys.nameRequired.tr(), isError: true);
        return false;
      }
      if (params.mainCategory == null || params.mainCategory!.isEmpty) {
        showToast(message: LocaleKeys.mainCategoryRequired.tr(), isError: true);
        return false;
      }
      if (params.subCategory == null || params.subCategory!.isEmpty) {
        showToast(message: LocaleKeys.subCategoryRequired.tr(), isError: true);
        return false;
      }
      if (params.description == null || params.description!.trim().isEmpty) {
        showToast(message: LocaleKeys.descriptionRequired.tr(), isError: true);
        return false;
      }
      return true;

    case 1:
      final phone = params.contact.phone?.trim() ?? "";
      if (phone.isEmpty) {
        showToast(message: LocaleKeys.phoneRequired.tr(), isError: true);
        return false;
      }
      if (!RegExp(r'^\\d+\$').hasMatch(phone)) {
        showToast(message: LocaleKeys.phoneMustBeNumeric.tr(), isError: true);
        return false;
      }

      final whatsapp = params.contact.whatsapp?.trim() ?? "";
      if (whatsapp.isNotEmpty && !RegExp(r'^\\d+\$').hasMatch(whatsapp)) {
        showToast(message: LocaleKeys.whatsappMustBeNumeric.tr(), isError: true);
        return false;
      }

      final insta = params.contact.instagram?.trim() ?? "";
      final facebook = params.contact.facebook?.trim() ?? "";

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
      if (params.location.lat == null || params.location.lng == null) {
        showToast(message: LocaleKeys.locationIsRequired.tr(), isError: true);
        return false;
      }
      return true;

    case 3:
      if (params.openTime != null &&
          params.openTime!.isNotEmpty &&
          params.closeTime != null &&
          params.closeTime!.isNotEmpty) {
        final open = parseTime(params.openTime!);
        final close = parseTime(params.closeTime!);
        if (open != null && close != null && !isTimeBefore(open, close)) {
          showToast(message: LocaleKeys.openTimeMustBeBeforeCloseTime.tr(), isError: true);
          return false;
        }
      }

      if (!(params.acceptOptions.acceptOne ?? false)) {
        showToast(message: LocaleKeys.youMustAcceptTheTerms.tr(), isError: true);
        return false;
      }
      if (!(params.acceptOptions.acceptTwo ?? false)) {
        showToast(message: LocaleKeys.youMustReviewSubscriptionCost.tr(), isError: true);
        return false;
      }
      if (!(params.acceptOptions.acceptThree ?? false)) {
        showToast(message: LocaleKeys.youMustConfirmInformationAccuracy.tr(), isError: true);
        return false;
      }

      if (!params.recaptcha) {
        showToast(message: LocaleKeys.verifyYouAreNotRobot.tr(), isError: true);
        return false;
      }

      return true;

    default:
      return true;
  }
}
