import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_spot.freezed.dart';

@freezed
class ChartSpot with _$ChartSpot {
  const factory ChartSpot({
    required DateTime dateTime,
    required int count,
  }) = _ChartSpot;
}
