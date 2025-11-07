import 'package:fluttertoast/fluttertoast.dart';

import '../../resources/color_manager.dart';

Future<void> showToast({required String message}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: ColorManager.primary,
    textColor: ColorManager.white,
    fontSize: 16.0,
  );
}
