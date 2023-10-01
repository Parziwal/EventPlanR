import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrganizationItem extends StatelessWidget {
  const OrganizationItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const AspectRatio(
                aspectRatio: 1,
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1780&q=80'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Organization name',
                  style: theme.textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () => context.go(
                  PagePaths.userOrganizationsEdit('Test'),
                ),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
