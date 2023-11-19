import 'package:event_planr_app/domain/models/news_post/organization_news_post.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organization_event_news/cubit/organization_event_news_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/confirmation_dialog.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/datetime_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPostItem extends StatelessWidget {
  const NewsPostItem({required this.newsPost, super.key});

  final OrganizationNewsPost newsPost;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
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
                    '${l10n.organizationEventNews_Created} '
                    '${newsPost.createdBy ?? '-'}, '
                    '${formatDateTime(context, newsPost.created)}',
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _deleteNews(context),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteNews(BuildContext context) {
    final l10n = context.l10n;
    final eventId = context.goRouterState.pathParameters['eventId']!;

    showConfirmationDialog(
      context,
      message: l10n.organizationEventNews_AreYouSureYouWantToDeleteNews(
        newsPost.title,
      ),
    ).then((value) {
      if (value ?? false) {
        context
            .read<OrganizationEventNewsCubit>()
            .deleteNews(evenId: eventId, newsId: newsPost.id);
      }
    });
  }
}
