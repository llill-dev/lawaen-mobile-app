import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// This function is for converting the url image to a file.
Future<File> convertImageUrlToFile(String? imageUrl) async {
  dynamic rng = Random();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('$tempPath${rng.nextInt(100)}.png');
  http.Response response = await http.get(Uri.parse(imageUrl.toString()));
  await file.writeAsBytes(response.bodyBytes);
  return file;
}

/// This function is for converting the path image to a file.

Future<File> convertImagePathToFile(String path) async {
  final byteData = await rootBundle.load(path);

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

String convertFrom12To24HourTypes({required String currentTime}) {
  if (currentTime.isNotEmpty) {
    List<String> parts = currentTime.split(" ");
    List<String> time = parts[0].split(":");
    String hourStr = time[0];
    String minuteStr = time[1];
    String amPm = parts[1];

    int hour = int.parse(hourStr);

    if (amPm == "AM" && hour == 12) {
      hour = 0;
    } else if (amPm == "PM" && hour != 12) {
      hour += 12;
    }

    hourStr = hour.toString().padLeft(2, '0');
    minuteStr = minuteStr.padLeft(2, '0');

    String time24hr = "$hourStr:$minuteStr";

    return time24hr;
  } else {
    return "";
  }
}

String convertDoubleToTime({required String decimalHours}) {
  int hours = double.parse(decimalHours).floor();
  int minutes = ((double.parse(decimalHours) - hours) * 60).round();
  String result = "";
  if (hours != 0) {
    result = "$hours hour";
  }
  result += " ${minutes.toString().padLeft(2, '0')} minute";
  return result;
}

String showChatDate(String dateString) {
  DateTime parsedDate = DateTime.parse(dateString);

  DateTime localDate = parsedDate.toLocal();

  // Get today's date without time part
  DateTime now = DateTime.now();
  bool isToday = localDate.year == now.year && localDate.month == now.month && localDate.day == now.day;

  if (isToday) {
    String time = DateFormat('hh:mm a').format(localDate);
    return "Today, $time";
  } else {
    return DateFormat('yyyy-MM-dd hh:mm a').format(localDate);
  }
}

String getMonthName(int month) {
  const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  return months[month - 1];
}
