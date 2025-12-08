import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

SliverToBoxAdapter buildSpace({double? height}) {
  return SliverToBoxAdapter(child: SizedBox(height: height ?? 20.h));
}

TimeOfDay? parseTime(String input) {
  final parts = input.split(':');
  if (parts.length != 2) return null;
  final h = int.tryParse(parts[0]);
  final m = int.tryParse(parts[1]);
  if (h == null || m == null) return null;
  return TimeOfDay(hour: h, minute: m);
}

bool isTimeBefore(TimeOfDay a, TimeOfDay b) {
  if (a.hour < b.hour) return true;
  if (a.hour == b.hour && a.minute < b.minute) return true;
  return false;
}

String safeMonthName(String? date) {
  if (date == null || date.isEmpty) return "";
  try {
    final parsed = DateTime.parse(date);
    return DateFormat('MMM').format(parsed);
  } catch (_) {
    return "";
  }
}

String safeDay(String? date) {
  if (date == null || date.isEmpty) return "";
  try {
    final parsed = DateTime.parse(date);
    return parsed.day.toString();
  } catch (_) {
    return "";
  }
}
