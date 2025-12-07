import 'package:lawaen/features/add_to_app/presentation/params/add_offer_params.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

bool validateAddOfferStep(AddOfferParams params, int step) {
  switch (step) {
    case 0:
      if (params.name == null || params.name!.trim().isEmpty) {
        showToast(message: LocaleKeys.nameRequired.tr(), isError: true);
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

      return true;

    case 2:
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
