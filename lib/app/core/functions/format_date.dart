import 'package:intl/intl.dart';

String formatDateRange(String fromDate, String toDate) {
  DateTime from = DateTime.parse(fromDate);
  DateTime to = DateTime.parse(toDate);

  final dayFrom = DateFormat('d').format(from);
  final dayTo = DateFormat('d').format(to);
  final monthYear = DateFormat('MMMM, yyyy').format(from);
  final time = DateFormat('HH:mm').format(from.toLocal());

  return '$dayFrom - $dayTo $monthYear, $time';
}

String formatLastUpdated(String updatedAt) {
  final date = DateTime.parse(updatedAt).toLocal();
  final formatted = DateFormat("MMMM d, yyyy").format(date);
  return "Last updated $formatted";
}
