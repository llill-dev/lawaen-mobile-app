import 'package:easy_localization/easy_localization.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_event_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

bool validateAddEventStep(AddEventParams params, int step) {
  switch (step) {
    case 0:
      if (params.name == null || params.name!.trim().isEmpty) {
        showToast(message: LocaleKeys.nameRequired.tr(), isError: true);
        return false;
      }
      return true;

    case 1:
      final instagram = params.contact.instagram?.trim() ?? "";
      final facebook = params.contact.facebook?.trim() ?? "";

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
      return true;

    case 3:
      if (params.location.lat == null || params.location.lng == null) {
        showToast(message: LocaleKeys.locationIsRequired.tr(), isError: true);
        return false;
      }
      return true;

    case 4:
      if (params.startTime == null || params.startTime!.isEmpty) {
        showToast(message: LocaleKeys.startTimeIsRequired.tr(), isError: true);
        return false;
      }

      if (params.endTime == null || params.endTime!.isEmpty) {
        showToast(message: LocaleKeys.endTimeIsRequired.tr(), isError: true);
        return false;
      }

      final start = parseTime(params.startTime!);
      final end = parseTime(params.endTime!);

      if (start != null && end != null && !isTimeBefore(start, end)) {
        showToast(message: LocaleKeys.startTimeMustBeBeforeEndTime.tr(), isError: true);
        return false;
      }

      if (params.startEventDate != null && params.endEventDate != null) {
        final startD = DateTime.tryParse(params.startEventDate!);
        final endD = DateTime.tryParse(params.endEventDate!);

        if (startD != null && endD != null && startD.isAfter(endD)) {
          showToast(message: LocaleKeys.startEventDateMustBeBeforeEndEventDate.tr(), isError: true);
          return false;
        }
      }

      if (params.eventTime != null && DateTime.tryParse(params.eventTime!) == null) {
        showToast(message: LocaleKeys.eventTimeMustBeValidDate.tr(), isError: true);
        return false;
      }

      if (params.note != null && params.note!.trim().isNotEmpty && params.note!.trim().length < 10) {
        showToast(message: LocaleKeys.noteMustBeAtLeast10Chars.tr(), isError: true);
        return false;
      }

      return true;

    default:
      return true;
  }
}
