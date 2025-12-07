import 'package:fluttertoast/fluttertoast.dart';

import '../../resources/color_manager.dart';

Future<void> showToast({required String message, bool isError = false, bool isSuccess = false}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: isError
        ? ColorManager.red
        : isSuccess
        ? ColorManager.green
        : ColorManager.primary,
    textColor: ColorManager.white,
    fontSize: 16.0,
  );
}
