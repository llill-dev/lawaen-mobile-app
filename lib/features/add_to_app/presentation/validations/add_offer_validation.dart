import 'package:lawaen/features/add_to_app/presentation/params/add_offer_params.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

bool validateAddOfferStep(AddOfferParams p, int step) {
  switch (step) {
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
