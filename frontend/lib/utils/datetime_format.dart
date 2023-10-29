import 'package:intl/intl.dart';

String formatEventDateTimeRange(DateTime from, DateTime to) {
  final fromDate = DateFormat.MMMEd().format(from);
  final toDate = DateFormat.MMMEd().format(to);
  final fromHour = DateFormat.jm().format(to);
  final fromYear = DateTime.now().year < from.year ? '${from.year}, ' : '';

  if (from.year == to.year && from.month == to.month && from.day == to.day) {
    return '$fromYear$fromDate • $fromHour';
  } else {
    return '$fromYear$fromDate - $toDate • $fromHour';
  }
}

String formatEventDetailsDateRange(DateTime from, DateTime to) {
  final fromDate = DateFormat.MMMEd().format(from);
  final toDate = DateFormat.MMMEd().format(to);
  final fromYear = DateTime.now().year < from.year ? '${from.year}, ' : '';

  if (from.year == to.year && from.month == to.month && from.day == to.day) {
    return '$fromYear$fromDate';
  } else {
    return '$fromYear$fromDate - $toDate';
  }
}

String formatEventDetailsTimeRange(DateTime from, DateTime to) {
  final fromHour = DateFormat.jm().format(to);
  final toHour = DateFormat.jm().format(to);
  final fromDate = DateFormat.Md().format(from);
  final toDate = DateFormat.Md().format(to);

  if (from.difference(to) < const Duration(days: 1)) {
    return '$fromHour - $toHour';
  } else {
    return '$fromDate $fromHour - $toDate $toHour';
  }
}

String formatDateTime(DateTime dateTime) {
  return '${DateFormat.yMEd().format(dateTime)}, '
      '${DateFormat.jm().format(dateTime)}';
}

String formatDateRange(DateTime from, DateTime to) {
  return '${DateFormat.yMEd().format(from)} - ${DateFormat.yMEd().format(to)}';
}
