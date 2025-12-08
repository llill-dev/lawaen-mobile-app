import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../generated/locale_keys.g.dart';
import 'toast_message.dart';

Future<void> launchURL({required String link, LaunchMode? mode}) async {
  final Uri url = Uri.parse(link);

  try {
    await launchUrl(
      url,
      mode: mode ?? LaunchMode.externalApplication, // Opens in external browser
    );
  } catch (e) {
    showToast(message: "${LocaleKeys.cannotOpenUrl.tr()} $e");
  }
}

Future<void> makePhoneCall(String phoneNumber) async {
  final uri = Uri.parse("tel:$phoneNumber");
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    showToast(message: "${LocaleKeys.cannotOpenUrl.tr()} $e");
  }
}

void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
  showToast(message: LocaleKeys.copiedToClipboard.tr());
}

Future<void> launchEmail(String email) async {
  final Uri emailUri = Uri(scheme: 'mailto', path: email);

  try {
    await launchUrl(emailUri, mode: LaunchMode.externalApplication);
  } catch (e) {
    showToast(message: "Cannot open email app: $e");
  }
}
