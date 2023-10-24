import 'package:event_planr_app/data/network/event_planr/news_post/news_post_client.dart';
import 'package:injectable/injectable.dart';

@singleton
class NewsPostRepository {
  NewsPostRepository({required NewsPostClient newsPostClient})
      : _newsPostClient = newsPostClient;

  final NewsPostClient _newsPostClient;
}
