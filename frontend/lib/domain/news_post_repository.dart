import 'package:event_planr_app/data/network/event_planr_api/models/create_news_post_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/news_post_manager/news_post_manager_client.dart';
import 'package:event_planr_app/domain/models/common/paginated_list.dart';
import 'package:event_planr_app/domain/models/news_post/create_news_post.dart';
import 'package:event_planr_app/domain/models/news_post/news_post_filter.dart';
import 'package:event_planr_app/domain/models/news_post/organization_news_post.dart';
import 'package:injectable/injectable.dart';

@singleton
class NewsPostRepository {
  NewsPostRepository({required NewsPostManagerClient newsPostClient})
      : _newsPostManagerClient = newsPostClient;

  final NewsPostManagerClient _newsPostManagerClient;

  Future<PaginatedList<OrganizationNewsPost>> getEventNewsPosts(
    NewsPostFilter filter,
  ) async {
    final news = await _newsPostManagerClient.getNewspostmanagerEventId(
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
    return _newsPostManagerClient.postNewspostmanagerEventId(
      eventId: newsPost.eventId,
      body: CreateNewsPostCommand(
        title: newsPost.title,
        text: newsPost.text,
      ),
    );
  }

  Future<void> deleteNewsPost(String newsPostId) async {
    await _newsPostManagerClient.deleteNewspostmanagerNewsPostId(
      newsPostId: newsPostId,
    );
  }
}
