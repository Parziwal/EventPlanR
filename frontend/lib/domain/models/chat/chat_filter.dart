import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_filter.freezed.dart';

@freezed
class ChatFilter with _$ChatFilter {
  const factory ChatFilter({
    int? pageNumber,
    int? pageSize,
  }) = _ChatFilter;
}
