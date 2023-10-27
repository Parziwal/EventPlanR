import 'package:event_planr_app/data/network/event_planr/models/create_news_post_command.dart';
import 'package:event_planr_app/data/network/event_planr/news_post/news_post_client.dart';
import 'package:event_planr_app/domain/models/common/paginated_list.dart';
import 'package:event_planr_app/domain/models/news_post/create_news_post.dart';
import 'package:event_planr_app/domain/models/news_post/organization_news_post.dart';
import 'package:event_planr_app/domain/models/news_post/organization_news_post_filter.dart';
import 'package:injectable/injectable.dart';

@singleton
class NewsPostRepository {
  NewsPostRepository({required NewsPostClient newsPostClient})
      : _newsPostClient = newsPostClient;

  final NewsPostClient _newsPostClient;

  Future<PaginatedList<OrganizationNewsPost>> getEventNewsPost(
    OrganizationNewsPostFilter filter,
  ) async {
    final news = await _newsPostClient.getNewspostEventId(
      eventId: filter.eventId,
      pageNumber: filter.pageNumber ?? 1,
      pageSize: filter.pageSize ?? 20,
    );

    return PaginatedList(
      items: news.items
          .map(
            (n) => OrganizationNewsPost(
              id: n.id,
              title: n.title,
              created: n.created,
              lastModified: n.lastModified,
              text: n.text,
              createdBy: n.createdBy,
              lastModifiedBy: n.lastModifiedBy,
            ),
          )
          .toList(),
      pageNumber: news.pageNumber,
      totalPages: news.totalPages,
      totalCount: news.totalCount,
      hasPreviousPage: news.hasPreviousPage,
      hasNextPage: news.hasNextPage,
    );
  }

  Future<String> createNewsPost(CreateNewsPost newsPost) async {
    return _newsPostClient.postNewspostEventId(
      eventId: newsPost.eventId,
      body: CreateNewsPostCommand(
        title: newsPost.title,
        text: newsPost.text,
      ),
    );
  }

  Future<void> deleteNewsPost(String newsPostId) async {
    await _newsPostClient.deleteNewspostNewsPostId(
      newsPostId: newsPostId,
    );
  }
}
