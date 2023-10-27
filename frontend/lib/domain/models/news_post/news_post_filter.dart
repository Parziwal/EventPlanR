import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_post_filter.freezed.dart';

@freezed
class NewsPostFilter with _$NewsPostFilter {
  const factory NewsPostFilter({
    required String eventId,
    int? pageNumber,
    int? pageSize,
  }) = _NewsPostFilter;
}
