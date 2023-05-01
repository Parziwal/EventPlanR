extension DateTimeX on DateTime {
  String toJson() => toUtc().toString();
}
