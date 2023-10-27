import 'package:event_planr_app/domain/models/news_post/create_news_post.dart';
import 'package:event_planr_app/domain/models/news_post/organization_news_post.dart';
import 'package:event_planr_app/domain/models/news_post/organization_news_post_filter.dart';
import 'package:event_planr_app/domain/news_post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organization_event_news_state.dart';

part 'organization_event_news_cubit.freezed.dart';

@injectable
class OrganizationEventNewsCubit extends Cubit<OrganizationEventNewsState> {
  OrganizationEventNewsCubit({
    required NewsPostRepository newsPostRepository,
  })  : _newsPostRepository = newsPostRepository,
        super(
          const OrganizationEventNewsState(
            status: OrganizationEventNewsStatus.idle,
          ),
        );

  final NewsPostRepository _newsPostRepository;

  Future<void> getEventNewsPosts({
    required String eventId,
    required int pageNumber,
  }) async {
    try {
      final newsPosts = await _newsPostRepository.getEventNewsPost(
        OrganizationNewsPostFilter(
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
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventNewsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: OrganizationEventNewsStatus.idle));
  }

  Future<void> createNews(CreateNewsPost news) async {
    try {
      await _newsPostRepository.createNewsPost(news);
      emit(
        state.copyWith(
          status: OrganizationEventNewsStatus.newsCreated,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventNewsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: OrganizationEventNewsStatus.idle));

    await getEventNewsPosts(eventId: news.eventId, pageNumber: 1);
  }

  Future<void> deleteNews({
    required String evenId,
    required String newsId,
  }) async {
    try {
      await _newsPostRepository.deleteNewsPost(newsId);
      emit(state.copyWith(status: OrganizationEventNewsStatus.newsDeleted));
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventNewsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: OrganizationEventNewsStatus.idle));

    await getEventNewsPosts(eventId: evenId, pageNumber: 1);
  }
}
