import 'package:event_planr_app/domain/event_general_repository.dart';
import 'package:event_planr_app/domain/models/news_post/news_post.dart';
import 'package:event_planr_app/domain/models/news_post/news_post_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_news_state.dart';

part 'event_news_cubit.freezed.dart';

@injectable
class EventNewsCubit extends Cubit<EventNewsState> {
  EventNewsCubit({
    required EventGeneralRepository eventGeneralRepository,
  })  : _eventGeneralRepository = eventGeneralRepository,
        super(
          const EventNewsState(
            status: EventNewsStatus.idle,
          ),
        );

  final EventGeneralRepository _eventGeneralRepository;

  Future<void> getEventNewsPosts({
    required String eventId,
    required int pageNumber,
  }) async {
    try {
      final newsPosts = await _eventGeneralRepository.getEventNewsPosts(
        NewsPostFilter(
          eventId: eventId,
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          newsPosts: pageNumber == 1
              ? newsPosts.items
              : [...state.newsPosts, ...newsPosts.items],
          pageNumber: newsPosts.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: EventNewsStatus.error,
          exception: e,
        ),
      );
    }
    emit(state.copyWith(status: EventNewsStatus.idle));
  }
}
