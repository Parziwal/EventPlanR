import 'package:event_planr_app/domain/models/news_post/news_post.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/datetime_format.dart';
import 'package:flutter/material.dart';

class NewsPostItem extends StatelessWidget {
  const NewsPostItem({required this.newsPost, super.key});

  final NewsPost newsPost;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsPost.title,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              newsPost.text,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Text(
              formatDateTime(newsPost.lastModified),
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
