import 'package:easy_localization/easy_localization.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../generated/locale_keys.g.dart';
import 'toast_message.dart';

Future<void> launchURL({required String link}) async {
  final Uri url = Uri.parse(link);

  try {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Opens in external browser
    );
  } catch (e) {
    showToast(message: "${LocaleKeys.cannotOpenUrl.tr()} $e");
  }
}
