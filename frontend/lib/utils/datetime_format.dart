import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String formatEventDateTimeRange(
  BuildContext context,
  DateTime from,
  DateTime to,
) {
  final fromDate = DateFormat.MMMEd(context.l10n.localeName).format(from);
  final toDate = DateFormat.MMMEd(context.l10n.localeName).format(to);
  final fromHour = DateFormat.jm(context.l10n.localeName).format(from);
  final fromYear = DateTime.now().year < from.year ? '${from.year}, ' : '';

  if (from.year == to.year && from.month == to.month && from.day == to.day) {
    return '$fromYear$fromDate • $fromHour';
  } else {
    return '$fromYear$fromDate - $toDate • $fromHour';
  }
}

String formatEventDetailsDateRange(
  BuildContext context,
  DateTime from,
  DateTime to,
) {
  final fromDate = DateFormat.MMMEd(context.l10n.localeName).format(from);
  final toDate = DateFormat.MMMEd(context.l10n.localeName).format(to);
  final fromYear = DateTime.now().year < from.year ? '${from.year}, ' : '';

  if (from.year == to.year && from.month == to.month && from.day == to.day) {
    return '$fromYear$fromDate';
  } else {
    return '$fromYear$fromDate - $toDate';
  }
}

String formatEventDetailsTimeRange(
  BuildContext context,
  DateTime from,
  DateTime to,
) {
  final fromHour = DateFormat.jm(context.l10n.localeName).format(from);
  final toHour = DateFormat.jm(context.l10n.localeName).format(to);
  final fromDate = DateFormat.Md(context.l10n.localeName).format(from);
  final toDate = DateFormat.Md(context.l10n.localeName).format(to);

  if (from.difference(to) < const Duration(days: 1)) {
    return '$fromHour - $toHour';
  } else {
    return '$fromDate $fromHour - $toDate $toHour';
  }
}

String formatDateTime(BuildContext context, DateTime dateTime) {
  return '${DateFormat.yMEd(context.l10n.localeName).format(dateTime)}, '
      '${DateFormat.jm(context.l10n.localeName).format(dateTime)}';
}

String formatDateRange(BuildContext context, DateTime from, DateTime? to) {
  return '${DateFormat.yMEd(context.l10n.localeName).format(from)} - '
      '${to != null ? DateFormat.yMEd(
          context.l10n.localeName,
        ).format(to) : ''}';
}
