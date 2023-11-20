part of 'event_news_cubit.dart';

enum EventNewsStatus { idle, error }

@freezed
class EventNewsState with _$EventNewsState {
  const factory EventNewsState({
    required EventNewsStatus status,
    @Default([]) List<NewsPost> newsPosts,
    int? pageNumber,
    Exception? exception,
  }) = _EventNewsState;
}
