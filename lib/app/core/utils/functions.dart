import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../resources/color_manager.dart';

Future<String?> pickFormattedDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(DateTime.now().year + 100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: ColorManager.primary)),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    return formattedDate;
  }

  return null;
}

String formattedTime(int remainingSeconds) {
  final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
  final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
