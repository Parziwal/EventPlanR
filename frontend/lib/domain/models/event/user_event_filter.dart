import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event_filter.freezed.dart';

@freezed
class UserEventFilter with _$UserEventFilter {
  const factory UserEventFilter({
    int? pageNumber,
    int? pageSize,
  }) = _UserEventFilter;
}
